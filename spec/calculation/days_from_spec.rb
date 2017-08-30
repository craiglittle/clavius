RSpec.describe Clavius::Calculation::DaysFrom do
  subject(:calculation) { described_class.new(schedule, number) }

  let(:schedule) {
    Clavius::Schedule.new do |c|
      c.weekdays = %i[mon tue wed thu]
      c.included = [Date.new(2012, 1, 3), Date.new(2012, 1, 6)]
      c.excluded = [Date.new(2012, 1, 4)]
    end
  }

  context 'when initializing' do
    context 'with an integer' do
      let(:number) { 1 }

      it 'is successful' do
        expect(calculation.after(Date.new(2012, 1, 1))).to eq(
          Date.new(2012, 1, 2)
        )
      end
    end

    context 'with a valid integer-like value' do
      let(:number) { '1' }

      it 'is successful' do
        expect(calculation.after(Date.new(2012, 1, 1))).to eq(
          Date.new(2012, 1, 2)
        )
      end
    end

    context 'with an invalid integer-like value' do
      let(:number) { '1one' }

      it 'fails hard' do
        expect { calculation }.to raise_error ArgumentError
      end
    end

    context 'with a non-integer value' do
      let(:number) { [] }

      it 'fails hard' do
        expect { calculation }.to raise_error TypeError
      end
    end
  end

  describe '#before' do
    context 'when the number is non-zero' do
      let(:number) { 10 }

      it 'returns the appropriate date before the origin' do
        expect(calculation.before(Date.new(2012, 1, 18))).to eq(
          Date.new(2012, 1, 2)
        )
      end
    end

    context 'when the number is zero' do
      let(:number) { 0 }

      context 'and the origin is active' do
        let(:origin) { Date.new(2012, 1, 11) }

        it 'returns the origin date' do
          expect(calculation.before(origin)).to eq origin
        end
      end

      context 'and the origin is inactive' do
        let(:origin) { Date.new(2012, 1, 13) }

        it 'returns the first active date before the origin' do
          expect(calculation.before(origin)).to eq Date.new(2012, 1, 12)
        end
      end
    end
  end

  describe '#after' do
    context 'when the number is non-zero' do
      let(:number) { 10 }

      it 'returns the appropriate date after the origin' do
        expect(calculation.after(Date.new(2012, 1, 2))).to eq(
          Date.new(2012, 1, 18)
        )
      end
    end

    context 'when the number is zero' do
      let(:number) { 0 }

      context 'and the origin is active' do
        let(:origin) { Date.new(2012, 1, 11) }

        it 'returns the origin' do
          expect(calculation.after(origin)).to eq origin
        end
      end

      context 'and the origin is inactive' do
        let(:origin) { Date.new(2012, 1, 8) }

        it 'returns the first active date after the origin' do
          expect(calculation.after(origin)).to eq Date.new(2012, 1, 9)
        end
      end
    end
  end
end
