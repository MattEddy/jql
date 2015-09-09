require 'spec_helper'
require 'json'

module JsonQL
  describe Executor do
    let(:executor) do
      described_class.new(
        dataset: JSON.parse(File.read(File.dirname(__FILE__) + '/../fixtures/events.json'))
      )
    end

    describe "#execute" do
      it "can select a single column" do
        result = executor.execute("SELECT invited_count FROM events")

        expect(result).to eq [{"invited_count"=>[120, 23, 64, 55]}]
      end

      it "can select all columns" do
        result = executor.execute("SELECT * FROM events")

        expect(result).to eq([
          {"occasion"=> [
            "Birthday party",
            "Technical discussion",
            "Press release",
            "New year party"
          ]},
          {"invited_count"=> [120, 23, 64, 55]},
          {"year"=> [2015, 2015, 2015, 2016]},
          {"month"=> [3, 4, 6, 1]},
          {"day"=> [14, 24, 7, 1]}
        ])
      end

      it "can do greater than conditions" do
        result = executor.execute(%(SELECT invited_count FROM events WHERE
          invited_count > 64))

        expect(result).to eq [{"invited_count"=>[120]}]
      end

      it "can do less than conditions" do
        result = executor.execute(%(SELECT invited_count FROM events WHERE
          invited_count < 64))

        expect(result).to eq [{"invited_count"=>[23, 55]}]
      end

      it "can do equality conditions" do
        result = executor.execute(%(SELECT occasion FROM events WHERE occasion
          = 'Birthday party'))

        expect(result).to eq [{"occasion"=>["Birthday party"]}]
      end

      it "will return nothing if nothing is found" do
        result = executor.execute(%(SELECT * FROM events WHERE year = 1))
        expect(result).to eq "Nothing matched query"
      end
    end
  end
end
