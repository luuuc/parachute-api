source 'https://rubygems.org'
ruby "2.1.2"

gem 'rails', '4.1.5'
gem 'pg'

gem 'bcrypt', '~> 3.1.7'
gem 'kaminari'
gem 'active_model_serializers'

gem 'sdoc', '~> 0.4.0', group: :doc

group :development do
  gem 'spring'
  gem 'rack-cors', require: 'rack/cors'
  gem 'gemnasium'
  gem 'meta_request'
  gem 'better_errors'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'shoulda-matchers', require: false
  gem 'database_cleaner'
  gem 'codeclimate-test-reporter', require: false
end

group :production do
  gem 'puma'
  gem 'rails_12factor'
end