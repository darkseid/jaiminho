source 'https://rubygems.org'

gem 'rails', '4.1.6'
gem 'mysql2'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development
gem 'twitter-bootstrap-rails'
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', :require => nil
gem 'haml-rails'
gem 'unicorn'

gem "bullet", :group => "development"

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0'
  gem 'codeclimate-test-reporter'
  gem 'pry'
  gem 'mailcatcher'
  gem 'shoulda-matchers', require: false
  gem 'factory_girl_rails', :require => false
  gem 'faker'
end

group :test do
  gem 'database_cleaner'
end

gem 'simplecov', :require => false, :group => :test
gem 'aws-sdk'