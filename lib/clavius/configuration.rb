module Clavius
  class Configuration

    def initialize
      @raw = Raw.new.tap do |raw| yield raw if block_given? end
    end

    def weekdays
      @weekdays ||= begin
        raw
          .weekdays
          .select(&Time::WEEKDAYS.method(:include?))
          .map(&Time::WEEKDAYS.method(:index))
          .to_set
          .freeze
      end
    end

    def included
      @included ||= begin
        raw
          .included
          .select { |date| date.respond_to?(:to_date) }
          .map(&:to_date)
          .to_set
          .freeze
      end
    end

    def excluded
      @excluded ||= begin
        raw
          .excluded
          .select { |date| date.respond_to?(:to_date) }
          .map(&:to_date)
          .to_set
          .freeze
      end
    end

    protected

    attr_reader :raw

    Raw = Struct.new(:weekdays, :included, :excluded) do
      module Default
        WEEKDAYS = Set.new(%i[mon tue wed thu fri]).freeze
        INCLUDED = Set.new.freeze
        EXCLUDED = Set.new.freeze
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
