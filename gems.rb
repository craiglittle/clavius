# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

group :ci do
  gem 'simplecov', '~> 0.16.0', require: false
end

group :development do
  gem 'bump', '~> 0.6.0', require: false
end

group :ci, :development do
  gem 'rake',    '~> 12.0',   require: false
  gem 'rspec',   '~> 3.0',    require: false
  gem 'rubocop', '~> 0.62.0', require: false
end
