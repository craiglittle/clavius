module Clavius
  module Calculation
    class DaysFrom

      def initialize(schedule, number_of_days)
        @schedule       = schedule
        @number_of_days = Integer(number_of_days)
      end

      def before(date)
        schedule.before(date).take(number_of_days).to_a.last
      end

      def after(date)
        schedule.after(date).take(number_of_days).to_a.last
      end

      protected

      attr_reader :schedule,
                  :number_of_days

    end
  end
end
