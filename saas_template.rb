require 'pry'

repo_url = 'https://raw.githubusercontent.com/badmonkeys/bad_monkey_rails/master'

def remove_comments_for(filename)
  gsub_file filename, /^\s*#.*\n/, ''
end

def remove_default_gemfile
  comment_lines 'Gemfile', ''
  remove_comments_for('Gemfile')
end

def append_to_file(filename, contents)
  open(filename, 'a') {|f| f.puts contents }
end

# =============================================================================
# Gem setup
remove_default_gemfile
add_source 'https://rubygems.org'

gem 'bootstrap'
gem 'coffee-rails', '~> 4.2'
gem 'dotenv'
gem 'flipper-active_record', git: 'https://github.com/badmonkeys/flipper.git'
gem 'haml'
gem 'jquery-rails'
gem 'pg'
gem 'pry-rails'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.0'
gem 'sass-rails', '~> 5.0'
gem 'sidekiq'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

gem_group :development do
  gem 'web-console'
end

gem_group :development, :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'foreman'
  gem 'guard-bundler', require: false
  gem 'guard-rspec',   require: false
  gem 'listen', '~> 3.0.5'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'simplecov', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem_group :production do
  gem 'rails_12factor'
end

after_bundle do
  # =============================================================================
  # General Setup
  get "#{repo_url}/config/database.yml.sample", 'config/database.yml.sample'
  run 'cp config/database.yml.sample config/database.yml'
  gsub_file 'config/database.yml', /<APP_NAME>/, app_name
  remove_comments_for('config/database.yml')
  get "#{repo_url}/sample.env", '.env'

  # =============================================================================
  # Setup RSpec
  run 'spring stop'
  generate 'rspec:install'
  uncomment_lines 'spec/rails_helper.rb', /Dir\[Rails\.root\.join/
  run 'rm spec/spec_helper.rb'
  get "#{repo_url}/spec/spec_helper.rb", 'spec/spec_helper.rb'
  remove_comments_for 'spec/rails_helper.rb'

  get "#{repo_url}/Guardfile", 'Guardfile'
  get "#{repo_url}/spec/support/factory_girl.rb", 'spec/support/factory_girl.rb'
  get "#{repo_url}/spec/support/database_cleaner.rb", 'spec/support/database_cleaner.rb'
  create_file 'spec/support/capybara.rb', <<-CODE
require 'capybara/rspec'
  CODE

  # =============================================================================
  # setup Puma
  run 'rm config/puma.rb'
  get "#{repo_url}/config/puma.rb", 'config/puma.rb'

  # =============================================================================
  # Setup Sidekiq
  application 'config.active_job.queue_adapter = :sidekiq'

  # =============================================================================
  # Setup foreman
  file 'Procfile', <<-CODE
web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -q default
  CODE

  # =============================================================================
  # Setup flipper
  generate('flipper:active_record')
  initializer 'flipper.rb' , <<-CODE
require 'flipper/adapters/active_record'
$flip = Flipper.new(Flipper::Adapters::ActiveRecord.new)
  CODE

  # =============================================================================
  # Setup Bootstrap
  run "rm app/assets/stylesheets/application.css"
  create_file 'app/assets/stylesheets/application.scss', <<-CODE
@import 'bootstrap';
  CODE
  gsub_file 'app/assets/javascripts/application.js', /\/\/= require turbolinks/, <<-CODE
//= require bootstrap
//= require turbolinks
  CODE







  # =============================================================================
  # Setup Git
  git :init
  run 'rm .gitignore'
  create_file '.gitignore', <<-CODE
/.bundle

# Ignore all logfiles and tempfiles.
/log/*
/tmp/*
!/log/.keep
!/tmp/.keep

.byebug_history
/coverage/*
.env*
  CODE


# TODO:
  # app env
  # clockwork
  # bugsnag
  #   heroku setup
  # new relic
  #   heroku setup
  # rails flashes in templates
  # bundler audit
  # RACK::Deflator
  #   or heroku deflator
  # high_voltage

end


