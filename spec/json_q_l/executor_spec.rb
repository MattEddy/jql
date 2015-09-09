require 'spec_helper'

module JsonQL
  describe Executor do
    let(:executor) do
      described_class.new(
        file: File.read(File.dirname(__FILE__) + '/../fixtures/events.json')
      )
    end

    describe "#execute" do
      context "executes selects on a single column" do
        let(:query) { executor.execute("select occasion from events") }

        it "returns the appropriate data" do
          expect(query.first[:data]).to eq([
            "Birthday party",
            "Technical discussion",
            "Press release",
            "New year party"
          ])
        end

        it "return the appropriate column name" do
          expect(query.first[:column_name]).to eq "occasion"
        end
      end

      context "executes selects on multiple columns" do
        let(:query) do
          executor.execute("select occasion invited_count from events")
        end

        it "returns the appropriate data" do
          expect(query[1][:data]).to eq([120, 23, 64, 55])
        end

        it "returns the appropriate column name" do
          expect(query[1][:column_name]).to eq("invited_count")
        end

        it "has the first column" do
          expect(query[0][:column_name]).to eq("occasion")
        end
      end

      context "executes selects on all columns" do
        let(:query) { executor.execute("select * from events") }

        it "returns the appropriate events" do
          expect(query[0][:column_name]).to eq("occasion")
        end
      end

      context "executes selects filtering by the ruby condition provided" do
        it "can filter by numbers" do
          query = executor.execute(%(select invited_count from events where
            invited_count > 60))

          expect(query[0][:data]).to eq([120, 64])
        end

        it "can filter by strings" do
          query = executor.execute(%(select invited_count from events where
            occasion == 'Technical discussion'))

          expect(query[0][:data]).to eq([23])
        end
      end
    end
  end
end
