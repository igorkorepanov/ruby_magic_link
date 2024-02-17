# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

group :test do
  gem 'rspec', '3.12.0', require: false
  gem 'simplecov', '0.22.0', require: false
  gem 'timecop', '0.9.8', require: false

  gem 'rubocop', '1.59.0', require: false
  gem 'rubocop-performance', '1.20.2', require: false
  gem 'rubocop-rspec', '2.26.1', require: false
end

group :development do
  gem 'rake'
end

group :development, :test do
  gem 'rbs', '3.4.3', require: false
  gem 'steep', '1.6.0', require: false
end
