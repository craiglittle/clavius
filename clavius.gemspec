# frozen_string_literal: true

require File.expand_path('lib/clavius/version', __dir__)

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
  gem.metadata    = {'rubygems_mfa_required' => 'true'}

  gem.required_ruby_version = '>= 2.7'
end
