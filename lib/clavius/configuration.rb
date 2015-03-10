module Clavius
  class Configuration

    include Memoizable

    def initialize
      @raw = Raw.new.tap do |raw| yield raw end
    end

    def weekdays
      raw.weekdays
        .select { |weekday| Time::WEEKDAYS.include?(weekday) }
        .map    { |weekday| Time::WEEKDAYS.index(weekday) }
        .to_set
    end

    def included
      raw.included
        .select { |date| date.respond_to?(:to_date) }
        .map(&:to_date)
        .to_set
    end

    def excluded
      raw.excluded
        .select { |date| date.respond_to?(:to_date) }
        .map(&:to_date)
        .to_set
    end

    protected

    attr_reader :raw

    memoize :weekdays,
            :included,
            :excluded

    Raw = Struct.new(:weekdays, :included, :excluded) do
      module Default

        WEEKDAYS = Set.new(%i[mon tue wed thu fri])
        INCLUDED = Set.new
        EXCLUDED = Set.new

      end

      def initialize(*)
        super

        self.weekdays ||= Default::WEEKDAYS
        self.included ||= Default::INCLUDED
        self.excluded ||= Default::EXCLUDED
      end
    end

  end
end
