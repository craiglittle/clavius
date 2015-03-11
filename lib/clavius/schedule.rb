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

    def before(date)
      date.to_date.prev_day.downto(Time::BIG_BANG).lazy
        .select(&method(:active?))
    end

    def after(date)
      date.to_date.next_day.upto(Time::HEAT_DEATH).lazy
        .select(&method(:active?))
    end

    protected

    attr_reader :configuration

  end
end
