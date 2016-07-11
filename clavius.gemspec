require File.expand_path('../lib/clavius/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'clavius'
  gem.version     = Clavius::VERSION
  gem.authors     = ['Craig Little']
  gem.email       = %w[craiglttl@gmail.com]
  gem.summary     = 'Date calculations'
  gem.description = 'Date calculations based on a schedule.'
  gem.homepage    = 'https://github.com/craiglittle/clavius'
  gem.license     = 'MIT'
  gem.files       = Dir['lib/**/*', 'README.md']

  gem.required_ruby_version = '>= 2.0'

  gem.add_development_dependency 'rake',  '~> 11.0'
  gem.add_development_dependency 'rspec', '~> 3.0'
end
