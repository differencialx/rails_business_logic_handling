source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.3"

gem "rails", "~> 7.0.4", ">= 7.0.4.2"

gem "sqlite3", "~> 1.4"

gem "puma", "~> 5.0"

gem 'sprockets-rails', :require => 'sprockets/railtie'
gem "jsbundling-rails"

gem 'draper'
gem 'oj'
gem 'alba'
gem 'pagy', '~> 6.0'


gem 'trailblazer-rails'
gem "trailblazer-macro-contract"
gem "reform"
gem "dry-validation"

gem 'simple_endpoint', '~> 2.0.0'

gem "interactor", "~> 3.0"

gem 'decouplio', '~> 1.0.0rc'

gem 'yaso'

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem 'faraday'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'rspec-rails', '~> 6.0.0'
end

group :development do
  gem "web-console"
end
