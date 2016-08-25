$repo_url = 'https://raw.githubusercontent.com/badmonkeys/bad_monkey_rails/master'

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

def repo_get(path)
  get "#{$repo_url}/#{path}", path
end

# =============================================================================
# Gem setup
remove_default_gemfile
add_source 'https://rubygems.org'

gem 'autoprefixer-rails'
gem 'bullet'
gem 'bundler-audit'
gem 'bootstrap'
gem 'coffee-rails', '~> 4.2'
gem 'flipper-active_record'
gem 'goldiloader'
gem 'haml'
gem 'high_voltage'
gem 'jquery-rails'
gem 'newrelic_rpm'
gem 'pg'
gem 'pry-rails'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.0'
add_source 'https://rails-assets.org' do
  gem 'rails-assets-tether'
end
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
  gem 'dotenv-rails'
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
  gem 'heroku-deflater'
  gem 'rails_12factor'
end

after_bundle do
  # =============================================================================
  # General Setup
  remove_comments_for 'config/environments/test.rb'
  remove_comments_for 'config/environments/development.rb'
  remove_comments_for 'config/environments/production.rb'

  # =============================================================================
  # General Setup
  repo_get 'config/database.yml.sample'
  run 'cp config/database.yml.sample config/database.yml'
  gsub_file 'config/database.yml', /<APP_NAME>/, app_name
  remove_comments_for('config/database.yml')
  repo_get 'sample.env'
  run 'cp sample.env .env'
  repo_get 'lib/app_env.rb'
  initializer 'app_env.rb', <<-CODE
require 'app_env'
  CODE

  log(:bad_monkey, 'there is a bug in asset compilation requiring a file to exist')
  create_file 'app/assets/javascripts/channels/channel.js', ''

  # =============================================================================
  # Setup RSpec
  run 'spring stop'
  run 'rm -rf test/'
  generate 'rspec:install'
  uncomment_lines 'spec/rails_helper.rb', /Dir\[Rails\.root\.join/
  run 'rm spec/spec_helper.rb'
  repo_get 'spec/spec_helper.rb'
  remove_comments_for 'spec/rails_helper.rb'

  repo_get 'Guardfile'
  repo_get 'spec/support/factory_girl.rb'
  repo_get 'spec/support/database_cleaner.rb'
  create_file 'spec/support/capybara.rb', <<-CODE
require 'capybara/rspec'
  CODE

  # =============================================================================
  # setup Puma
  run 'rm config/puma.rb'
  repo_get 'config/puma.rb'

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
//= require tether
//= require bootstrap
//= require turbolinks
  CODE

  # =============================================================================
  # Setup application layout
  run 'rm app/views/layouts/application.html.erb'
  run 'rm app/helpers/application_helper.rb'
  repo_get 'app/views/application/_navigation.haml'
  repo_get 'app/views/layouts/application.html.erb'
  gsub_file 'app/views/layouts/application.html.erb', /<APP_NAME>/, app_name.upcase
  repo_get 'app/helpers/application_helper.rb'
  gsub_file 'app/views/application/_navigation.haml', /<APP_NAME>/, app_name.upcase

  # =============================================================================
  # Setup HighVoltage for static pages
  repo_get 'config/initializers/high_voltage.rb'
  run 'mkdir app/views/pages'
  repo_get 'app/views/pages/landing.haml'
  repo_get 'app/views/pages/pricing.haml'
  repo_get 'app/views/pages/about.haml'

  # =============================================================================
  # Setup Bullet
  environment 'config.after_initialize do
      Bullet.tap do |b|
        b.enable        = true
        b.alert         = true
        b.bullet_logger = true
        b.console       = true
        b.rails_logger  = true
      end
    end',
    env: :development

  environment 'config.after_initialize do
      Bullet.tap do |b|
        b.enable        = true
        b.bullet_logger = true
        b.raise         = true
      end
    end',
    env: :test

  # =============================================================================
  # setup databases
  rails_command 'db:drop db:create db:migrate db:test:prepare'

  # =============================================================================
  # Setup Git
  run 'rm .gitignore'
  repo_get '.gitignore'
  git :init

  # =============================================================================
  # Setup Heroku app
  if yes?('Do you want to create a new heroku app for this project?')
    run "heroku create #{app_name}"
    run 'heroku plugins:install https://github.com/tpope/heroku-binstubs.git'
    run "heroku binstubs:create #{app_name}"
    run 'production addons:create heroku-postgresql:hobby-dev'
    run 'production addons:create newrelic:wayne'
    new_relic_key = `production config:get NEW_RELIC_LICENSE_KEY`
    run "newrelic install --license_key='#{new_relic_key}' '#{app_name}'"
  end
end

