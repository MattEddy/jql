require 'spec_helper'

module JsonQL
  describe Parser do

    let(:test_json) do
      JSON.parse(File.read(File.dirname(__FILE__) + '/../fixtures/events.json'))
    end


    describe "#table_select" do
      let(:instance)   { described_class.new(test_query) }
      let(:test_query) { "SELECT * FROM events" }

      it "should select the appropriate table" do
        expect(instance.table_select.call(test_json)).to eq test_json['events']
      end
    end

    describe "filter_conditions_from_tokens" do
      let(:test_query) { "SELECT * FROM events WHERE 1 < age" }
      let(:instance)   { described_class.new(test_query) }

      it "should call '.create_from_tokens' with condition tokens" do
        expect(Condition).to receive(:create_from_tokens).with(["1", "<", "age"])
        described_class.new(test_query).filter_conditions_from_tokens
      end
    end

    describe "#column_select" do
      it "should select all columns" do
        expect(described_class.new("SELECT * FROM events")
          .column_select
          .call(test_json['events']))
          .to eq [
            {"occasion"=> [
              "Birthday party",
              "Technical discussion",
              "Press release",
              "New year party"
            ]},
            {"invited_count"=>[120, 23, 64, 55]},
            {"year"=>[2015, 2015, 2015, 2016]},
            {"month"=>[3, 4, 6, 1]},
            {"day"=>[14, 24, 7, 1]}
          ]
      end

      it "should select all specific columns" do
        expect(described_class.new("SELECT invited_count year FROM events")
          .column_select
          .call(test_json['events']))
          .to eq [
            {"invited_count"=>[120, 23, 64, 55]},
            {"year"=>[2015, 2015, 2015, 2016]}
          ]
      end
    end
  end
end
