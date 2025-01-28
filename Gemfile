# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

group :test do
  gem 'rspec', '3.12.0', require: false
  gem 'simplecov', '0.22.0', require: false
  gem 'timecop', '0.9.10', require: false

  gem 'rubocop', '1.71.0', require: false
  gem 'rubocop-performance', '1.23.1', require: false
  gem 'rubocop-rspec', '3.4.0', require: false
end

group :development do
  gem 'rake'
end

group :development, :test do
  gem 'rbs', '3.8.1', require: false
  gem 'steep', '1.9.3', require: false
end
