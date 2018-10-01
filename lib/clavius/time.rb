# frozen_string_literal: true

module Clavius
  module Time
    WEEKDAYS   = %i[sun mon tue wed thu fri sat].freeze
    BIG_BANG   = Date.new(-100_000_000, 1, 1, Date::ITALY)
    HEAT_DEATH = Date.new(100_000_000, 1, 1, Date::ITALY)
  end
end
