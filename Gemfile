# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise', '~> 4.7', '>= 4.7.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara'
  gem 'factory_bot_rails', '~> 6.0'
  gem 'guard-rspec', require: false
  gem 'launchy'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 4.0.0'
  gem 'rubocop', '~> 0.86.0', require: false
end

group :development do
  gem 'bullet'
  gem 'listen', '~> 3.2'
  gem 'rubocop-rails', '~> 2.6'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'shoulda-matchers', '~> 4.3'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
