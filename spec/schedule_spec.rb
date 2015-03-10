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
end
