require 'spec_helper'

module JsonQL
  describe Tolkienizer do
    describe ".run" do
      it "breaks things into tokens split on whitespace" do
        expect(described_class.run("cats cats")).to eq ["cats", "cats"]
      end
    end
  end
end
