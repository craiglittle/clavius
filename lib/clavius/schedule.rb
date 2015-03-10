module Clavius
  class Schedule

    extend Forwardable

    def initialize(&config)
      @configuration = Configuration.new(&config)
    end

    delegate %i[
      weekdays
      included
      excluded
    ] => :configuration

    protected

    attr_reader :configuration

  end
end
