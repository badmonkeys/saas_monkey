RAILS_REQUIREMENT = "~> 5.0"

require 'pry'
require 'fileutils'
require 'shellwords'

def apply_template!
  validate_environment

  template    'Gemfile.tt', force: true
  template    'README.md.tt', force: true
  remove_file 'README.rdoc'
  copy_file   'Procfile'
  template    'Guardfile.tt'
  copy_file   'gitignore', '.gitignore', force: true
  template    'ruby-version.tt', '.ruby-version'
  template    'sample.env.tt'

  run 'bundle install'

  unless @t_options[:minimal]
    apply('devise.rb') if @t_options[:devise]
  end

  apply('app/template.rb')
  apply('bin/template.rb')
  apply('config/template.rb')
  apply('lib/template.rb')
  apply('spec/template.rb')

  rails_command('db:create db:migrate')

  generate_spring_binstubs

  unless @t_options[:minimal]
    apply('git.rb') if @t_options[:git]
    apply('heroku.rb') if @t_options[:heroku]
  end
end

def validate_environment
  assert_minimum_rails_version
  assert_valid_options
  assert_postgresql
  add_template_repository_to_source_path
  set_template_options
end

def set_template_options
  parse_template_args

  @t_options ||= {}
  @t_options.tap do |h|
    h[:force]   = @t_args['force']     || false
    h[:minimal] = @t_args['minimal']   || false
    h[:git]     = @t_args['git']       || true
    h[:heroku]  = @t_args['heroku']    || false
    h[:devise]  = @t_args['devise']    || false
    h[:user]    = @t_args['user']      || 'User'
    h[:remote]  = @t_args['remote']
  end

  unless @t_options[:force] || @t_options[:minimal]
    ask_option_questions
  end
end

def ask_option_questions
  @t_options[:git]    = ask_with_default('Initialize GIT?', :white, to_yn(@t_options[:git])) =~ /^y(es)?/i
  @t_options[:devise] = ask_with_default('Setup Devise for authentication?', :white, to_yn(@t_options[:devise])) =~ /^y(es)?/i
  if @t_options[:devise] && !@t_options[:user]
    @t_options[:user] = ask_with_default('Devise model class?', :white, @t_options[:user]).downcase.capitalize
  end

  @t_options[:heroku] = ask_with_default('Setup a new Heroku app using CLI?', :white, to_yn(@t_options[:heroku])) =~ /^y(es)?/i
end

def parse_template_args
  @t_args ||= {}
  args.each_with_index do |a, i|
    if a.include?('--m_')
      if a.include?('=')
        pair = a.split('=')
        @t_args[pair.first.gsub('--m_', '')] = pair.last
      else
        @t_args[a.gsub('--m_', '')] = true
      end
    end
  end
  @t_args
end

def assert_minimum_rails_version
  req = Gem::Requirement.new(RAILS_REQUIREMENT)
  rails_version = Gem::Version.new(Rails::VERSION::STRING)
  return if req.satisfied_by?(rails_version)

  prompt = "This template requires Rails #{RAILS_REQUIREMENT}. "\
           "You are using #{rails_version}. Continue anyway?"

  exit 1 if no?(prompt)
end

def assert_valid_options
  # TODO: Add support for api only option
  valid_options = {
    'skip_gemfile' => false,
    'skip_bundle' => false,
    'skip_git' => false,
    'edge' => false,
    'api' => false
  }

  valid_options.each do |key, exp|
    next unless options.key?(key)
    actual = options[key]
    unless actual == exp
      fail Rails::Generators::Error, "Unsupported option #{key}=#{actual}"
    end
  end
end

def assert_postgresql
  return if IO.read("Gemfile") =~ /^\s*gem ['"]pg['"]/
  fail Rails::Generators::Error,
    "This template requires PostgresQL, "\
    "but the pg gem isn't present in your Gemfile."
end

def add_template_repository_to_source_path
  if __FILE__ =~ %r{\Ahttps?://}
    source_paths.unshift(tmpDir = Dir.mktmpdir('saas-monkey-template-'))
    at_exit { FileUtils.remove_entry(tmpDir) }

    git clone: [
      '--quiet',
      'https://github.com/badmonkeys/saas_monkey.git',
      tmpDir
    ].map(&:shellescape).join(' ')
  else
    source_paths.unshift(File.dirname(__FILE__))
  end
end

def gemfile_requirement(name)
  @original_gemfile ||= IO.read("Gemfile")
  req = @original_gemfile[/gem\s+['"]#{name}['"]\s*(,[><~= \t\d\.\w'"]*).*$/, 1]
  req && req.gsub("'", %(")).strip.sub(/^,\s*"/, ', "')
end

def remove_comments_for(filename)
  gsub_file filename, /^\s*#.*\n/, ''
end

def ask_with_default(question, color, default)
  return default unless $stdin.tty?
  question = (question.split("?") << " [#{default}]?").join
  answer = ask(question, color)
  answer.to_s.strip.empty? ? default : answer
end

def to_yn(value)
  value ? 'y' : 'n'
end

apply_template!
