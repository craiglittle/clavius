RSpec.describe Clavius do
  context 'when configured' do
    before do
      described_class.configure do |c|
        c.weekdays = %i[mon tue thu fri]
        c.included = [Date.new(2012, 1, 8)]
        c.excluded = [Date.new(2012, 1, 4)]
      end
    end

    after do Thread.current[:clavius_schedule] = nil end

    describe '.weekdays' do
      it 'delegates to the top-level schedule' do
        expect(described_class.weekdays).to eq Set[1, 2, 4, 5]
      end
    end

    describe '.included' do
      it 'delegates to the top-level schedule' do
        expect(described_class.included).to eq Set[Date.new(2012, 1, 8)]
      end
    end

    describe '.excluded' do
      it 'delegates to the top-level schedule' do
        expect(described_class.excluded).to eq Set[Date.new(2012, 1, 4)]
      end
    end

    describe '.before' do
      it 'delegates to the top-level schedule' do
        expect(described_class.before(Date.new(2012, 1, 8)).first).to eq(
          Date.new(2012, 1, 6)
        )
      end
    end

    describe '.after' do
      it 'delegates to the top-level schedule' do
        expect(described_class.after(Date.new(2012, 1, 2)).first).to eq(
          Date.new(2012, 1, 3)
        )
      end
    end

    describe '.active?' do
      it 'delegates to the top-level schedule' do
        expect(described_class.active?(Date.new(2012, 1, 3))).to eq true
      end
    end

    describe '.days' do
      it 'delegates to the top-level schedule' do
        expect(described_class.days(3).after(Date.new(2012, 1, 2))).to eq(
          Date.new(2012, 1, 6)
        )
      end
    end

    describe '.between' do
      it 'delegates to the top-level schedule' do
        expect(
          described_class.between(Date.new(2012, 1, 2), Date.new(2012, 1, 3))
        ).to eq [Date.new(2012, 1, 2)]
      end
    end
  end

  context 'when not configured' do
    before do Thread.current[:clavius_schedule] = nil end

    it 'fails hard' do
      expect { described_class.weekdays }.to raise_error RuntimeError
    end
  end
end
