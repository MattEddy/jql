require 'spec_helper'

module JsonQL
  describe Parser do
    describe "#initialize" do
      it "throws an error if the first token is not select" do
        expect { described_class.new('cats from') }.to raise_error(ParseError)
      end

      it "doesn't throw an error if it starts with select" do
        expect { described_class.new("select from") }.not_to raise_error
      end

      it "throws an error if the tokens don't contain a from" do
        expect { described_class.new('select cats') }.to raise_error(ParseError)
      end

      it "doesn't throw an error if the tokens do contain a from" do
        expect { described_class.new('select from') }.not_to raise_error
      end
    end

    describe "#columns" do
      let(:parser) { Parser.new('select cats dogs from') }

      it "returns all tokens between the select and the from" do
        expect(parser.columns).to eq ['cats', 'dogs']
      end
    end

    describe "#conditions" do
      it "builds conditions if they are provided" do
        sentinel = double(create_from_tokens: "some_condition")
        stub_const('JsonQL::Condition', sentinel)

        expect(sentinel).to receive(:create_from_tokens).with(["1", "<", "age"])
        described_class.new("select cats from pets where 1 < age").conditions
      end
    end

    describe "#table_name" do
      let(:parser) { Parser.new('select cats dogs from pets') }

      it "returns the token after from" do
        expect(parser.table_name).to eq 'pets'
      end
    end
  end
end
