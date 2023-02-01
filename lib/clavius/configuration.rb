# frozen_string_literal: true

module Clavius
  class Configuration

    module Default
      WEEKDAYS = Set.new(%i[mon tue wed thu fri]).freeze
      INCLUDED = Set.new.freeze
      EXCLUDED = Set.new.freeze
    end

    def initialize
      @raw = Raw.new.tap do |raw| yield raw if block_given? end
    end

    def weekdays
      @weekdays ||=
        raw
          .weekdays
          .select { |weekday| Time::WEEKDAYS.include?(weekday) }
          .to_set { |weekday| Time::WEEKDAYS.index(weekday) }
          .freeze
    end

    def included
      @included ||= exception_configuration(raw.included)
    end

    def excluded
      @excluded ||= exception_configuration(raw.excluded)
    end

    private

    attr_reader :raw

    def exception_configuration(dates)
      dates
        .select { |date| date.respond_to?(:to_date) }
        .to_set(&:to_date)
        .freeze
    end

    Raw = Struct.new(:weekdays, :included, :excluded) do
      def initialize(*)
        super

        self.weekdays ||= Default::WEEKDAYS
        self.included ||= Default::INCLUDED
        self.excluded ||= Default::EXCLUDED
      end
    end

  end
end
