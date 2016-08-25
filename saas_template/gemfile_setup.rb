run 'rn Gemfile'
add_source 'https://rubygems.org'

gem 'autoprefixer-rails'
gem 'bullet'
gem 'bundler-audit'
gem 'bootstrap'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'flipper-active_record'
gem 'goldiloader'
gem 'haml'
gem 'high_voltage'
gem 'jquery-rails'
gem 'newrelic_rpm'
gem 'pg'
gem 'pry-rails'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.0.1'
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
