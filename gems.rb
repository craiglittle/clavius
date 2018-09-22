# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

group :ci do
  gem 'simplecov', '~> 0.16.0', require: false
end

group :development do
  gem 'bump',    '~> 0.5.0', require: false
  gem 'bundler', '~> 1.8',   require: false
end

group :development, :ci do
  gem 'rake',    '~> 12.0',   require: false
  gem 'rspec',   '~> 3.0',    require: false
  gem 'rubocop', '~> 0.59.0', require: false
end
