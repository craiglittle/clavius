RSpec.describe Clavius::Schedule do
  subject(:schedule) { described_class.new(&config) }

  let(:weekdays) { %i[mon wed fri] }
  let(:included) { [Date.new(2012, 1, 1), Date.new(2012, 1, 8)] }
  let(:excluded) { [Date.new(2012, 1, 2), Date.new(2012, 1, 9)] }

  let(:config) {
    proc do |c|
      c.weekdays = weekdays
      c.included = included
      c.excluded = excluded
    end
  }

  %i[weekdays included excluded].each do |input|
    describe "##{input}" do
      it 'delegates to the configuration' do
        expect(schedule.send(input)).to eq(
          Clavius::Configuration.new(&config).send(input)
        )
      end
    end
  end

  describe "#before" do
    it "returns active dates before the specified origin date" do
      expect(schedule.before(Date.new(2012, 1, 13)).take(5).to_a).to eq [
        Date.new(2012, 1, 11),
        Date.new(2012, 1, 8),
        Date.new(2012, 1, 6),
        Date.new(2012, 1, 4),
        Date.new(2012, 1, 1)
      ]
    end
  end

  describe "#after" do
    it "returns active dates after the specified origin date" do
      expect(schedule.after(Date.new(2012, 1, 1)).take(5).to_a).to eq [
        Date.new(2012, 1, 4),
        Date.new(2012, 1, 6),
        Date.new(2012, 1, 8),
        Date.new(2012, 1, 11),
        Date.new(2012, 1, 13)
      ]
    end
  end

  describe '#active?' do
    let(:weekdays) { %i[mon tue wed thu] }
    let(:included) {
      [
        Date.new(2012, 1, 3),
        Date.new(2012, 1, 4),
        Date.new(2012, 1, 6),
        Date.new(2012, 1, 7)
      ]
    }
    let(:excluded) {
      [
        Date.new(2012, 1, 4),
        Date.new(2012, 1, 5),
        Date.new(2012, 1, 7),
        Date.new(2012, 1, 8)
      ]
    }

    context 'when the date is date-like' do
      let(:date) { Time.new(2012, 1, 1) }

      it 'does not blow up' do
        expect { schedule.active?(date) }.not_to raise_error
      end
    end

    context 'when the date is not date-like' do
      let(:date) { 'date' }

      it 'blows up' do
        expect { schedule.active?(date) }.to raise_error
      end
    end

    context 'when the date falls on a configured weekday' do
      context "and is an explicit 'included' exception" do
        context "and is an explicit 'excluded' exception" do
          let(:date) { Date.new(2012, 1, 4) }

          it 'returns false' do
            expect(schedule.active?(date)).to eq false
          end
        end

        context "and is not an explicit 'excluded' exception" do
          let(:date) { Date.new(2012, 1, 3) }

          it 'returns true' do
            expect(schedule.active?(date)).to eq true
          end
        end
      end

      context "and is not an explicit 'included' exception" do
        context "and is an explicit 'excluded' exception" do
          let(:date) { Date.new(2012, 1, 5) }

          it 'returns false' do
            expect(schedule.active?(date)).to eq false
          end
        end

        context "and is not an explicit 'excluded' exception" do
          let(:date) { Date.new(2012, 1, 2) }

          it 'returns true' do
            expect(schedule.active?(date)).to eq true
          end
        end
      end
    end

    context 'when the date does not fall on a configured weekday' do
      context "and is an explicit 'included' exception" do
        context "and is an explicit 'excluded' exception" do
          let(:date) { Date.new(2012, 1, 7) }

          it 'returns false' do
            expect(schedule.active?(date)).to eq false
          end
        end

        context "and is not an explicit 'excluded' exception" do
          let(:date) { Date.new(2012, 1, 6) }

          it 'returns true' do
            expect(schedule.active?(date)).to eq true
          end
        end
      end

      context "and is not an explicit 'included' exception" do
        context "and is an explicit 'excluded' exception" do
          let(:date) { Date.new(2012, 1, 8) }

          it 'returns false' do
            expect(schedule.active?(date)).to eq false
          end
        end

        context "and is not an explicit 'excluded' exception" do
          let(:date) { Date.new(2012, 1, 1) }

          it 'returns false' do
            expect(schedule.active?(date)).to eq false
          end
        end
      end
    end
  end

  describe '#days' do
    it 'returns the active day after the specified number of active days' do
      expect(schedule.days(5).after(Date.new(2012, 1, 10))).to eq(
        Date.new(2012, 1, 20)
      )
    end
  end

  describe '#between' do
    let(:weekdays) { %i[mon tue wed thu] }
    let(:included) { [Date.new(2012, 1, 3), Date.new(2012, 1, 6)] }
    let(:excluded) { [Date.new(2012, 1, 4)] }

    context 'when the start date is the end date' do
      let(:start_date) { Date.new(2012, 1, 2) }
      let(:end_date)   { start_date }

      it 'returns no dates' do
        expect(schedule.between(start_date, end_date)).to eq []
      end
    end

    context 'when the start date is after the end date' do
      let(:start_date) { Date.new(2013) }
      let(:end_date)   { Date.new(2012) }

      it 'returns no dates' do
        expect(schedule.between(start_date, end_date)).to eq []
      end
    end

    context 'when the start date is before the end date' do
      let(:start_date) { Date.new(2012, 1, 1) }
      let(:end_date)   { Date.new(2012, 1, 17) }

      it 'returns the correct dates' do
        expect(schedule.between(start_date, end_date)).to eq [
          Date.new(2012, 1, 2),
          Date.new(2012, 1, 3),
          Date.new(2012, 1, 5),
          Date.new(2012, 1, 6),
          Date.new(2012, 1, 9),
          Date.new(2012, 1, 10),
          Date.new(2012, 1, 11),
          Date.new(2012, 1, 12),
          Date.new(2012, 1, 16)
        ]
      end
    end
  end
end
