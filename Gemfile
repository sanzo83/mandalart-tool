source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.11'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 8.0.5'
# Use SQLite as the database for Active Record
gem 'sqlite3', '~> 2.1'
# Use Puma as the app server
gem 'puma', '~> 6.4'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.18', require: false

gem 'rspec-rails'
gem 'matrix'
gem 'rexml'
# Rails 6.1's parallel test runner is compatible with Minitest 5.
gem 'minitest', '~> 5.25'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.5', '< 4.0'
  # Keep file watching compatible with Ruby 3.2.
  gem 'ffi', '~> 1.17'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
