RSpec.describe Clavius::Calculation::DaysFrom do
  subject(:calculation) { described_class.new(schedule, number_of_days) }

  let(:schedule) {
    Clavius::Schedule.new do |c|
      c.weekdays = %i[mon tue wed thu]
      c.included = [Date.new(2012, 1, 3), Date.new(2012, 1, 6)]
      c.excluded = [Date.new(2012, 1, 4)]
    end
  }

  let(:number_of_days) { 10 }

  context 'when initializing' do
    context 'with an integer number of days' do
      let(:number_of_days) { 1 }

      it 'is successful' do
        expect(calculation.after(Date.new(2012, 1, 1))).to eq(
          Date.new(2012, 1, 2)
        )
      end
    end

    context 'with an valid integer-like value' do
      let(:number_of_days) { '1' }

      it 'is successful' do
        expect(calculation.after(Date.new(2012, 1, 1))).to eq(
          Date.new(2012, 1, 2)
        )
      end
    end

    context 'with an invalid integer-like value' do
      let(:number_of_days) { '1one' }

      it 'fails hard' do
        expect { calculation }.to raise_error ArgumentError
      end
    end

    context 'with a non-integer value' do
      let(:number_of_days) { [] }

      it 'fails hard' do
        expect { calculation }.to raise_error TypeError
      end
    end
  end

  describe '#before' do
    it 'returns the date the number of active days before the origin date' do
      expect(calculation.before(Date.new(2012, 1, 18))).to eq(
        Date.new(2012, 1, 2)
      )
    end
  end

  describe '#after' do
    it 'returns the date the number of active days after the origin date' do
      expect(calculation.after(Date.new(2012, 1, 2))).to eq(
        Date.new(2012, 1, 18)
      )
    end
  end
end
