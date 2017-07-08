source 'https://rubygems.org'

gemspec

group :ci do
  gem 'codeclimate-test-reporter', '~> 1.0',    require: false
  gem 'simplecov',                 '~> 0.13.0', require: false
end

group :development do
  gem 'bump',    '~> 0.5.0', require: false
  gem 'bundler', '~> 1.0',   require: false
end

group :development, :ci do
  gem 'rake',    '~> 12.0',   require: false
  gem 'rspec',   '~> 3.0',    require: false
  gem 'rubocop', '~> 0.47.0', require: false
end
