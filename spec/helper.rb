if ENV['CODECLIMATE_REPO_TOKEN']
  require 'simplecov'

  SimpleCov.start
end

require 'clavius'

RSpec.configure do |config|
  config.color = true
  config.tty   = true
  config.order = :random

  config.disable_monkey_patching!
end
