# frozen_string_literal: true

RSpec.describe Clavius::Configuration do
  subject(:configuration) {
    described_class.new do |c|
      c.weekdays = weekdays
      c.included = included
      c.excluded = excluded
    end
  }

  let(:weekdays) { %i[mon wed fri] }
  let(:included) { [Date.new(2015, 1, 1), Date.new(2015, 1, 8)] }
  let(:excluded) { [Date.new(2015, 1, 2), Date.new(2015, 1, 9)] }

  context 'when initialized without a block' do
    it 'does not blow up' do
      expect { described_class.new }.not_to raise_error
    end
  end

  describe '#weekdays' do
    it 'returns the associated wdays' do
      expect(configuration.weekdays).to eq Set[1, 3, 5]
    end

    context 'when nonsensical values are provided' do
      let(:weekdays) { %i[hi there tue thu] }

      it 'filters them out' do
        expect(configuration.weekdays).to eq Set[2, 4]
      end
    end

    context 'when duplicate values are provided' do
      let(:weekdays) { %i[mon mon] }

      it 'filters them out' do
        expect(configuration.weekdays).to eq Set[1]
      end
    end

    context 'when unconfigured' do
      subject(:configuration) {
        described_class.new do |c|
          c.included = included
          c.excluded = excluded
        end
      }

      it 'returns the default set of wdays' do
        expect(configuration.weekdays).to eq Set[1, 2, 3, 4, 5]
      end
    end
  end

  %i[included excluded].each do |dates|
    describe "##{dates}" do
      it 'returns the configured dates' do
        expect(configuration.send(dates)).to eq send(dates).to_set
      end

      context 'when duplicate dates are provided' do
        let(dates) { Array.new(2) { Date.new(2015, 1, 1) } }

        it 'filters them out' do
          expect(configuration.send(dates)).to eq Set[Date.new(2015, 1, 1)]
        end
      end

      context 'when date-like objects are provided' do
        let(dates) { [Date.new(2015, 1, 1), Time.new(2015, 1, 2)] }

        it 'converts them to dates' do
          expect(configuration.send(dates)).to eq Set[
            Date.new(2015, 1, 1),
            Date.new(2015, 1, 2)
          ]
        end
      end

      context 'when un-date-like objects are provided' do
        let(dates) { [Date.new(2015, 1, 1), 'date'] }

        it 'filters them out' do
          expect(configuration.send(dates)).to eq Set[Date.new(2015, 1, 1)]
        end
      end

      context 'when unconfigured' do
        subject(:configuration) {
          described_class.new do |c| c.weekdays = weekdays end
        }

        it 'returns an empty set' do
          expect(configuration.send(dates)).to eq Set.new
        end
      end
    end
  end
end
