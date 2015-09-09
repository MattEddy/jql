require 'spec_helper'

module JsonQL
  describe Tolkienizer do
    describe ".run" do
      context "it chagnes the required logical operators" do
        it "changes single = to ==" do
          expect(described_class.run("cats = cats")).to eq ["cats", "==", "cats"]
        end

        it "changes AND to &&" do
          expect(described_class.run("cats AND cats")).to eq ["cats", "&&", "cats"]
        end

        it "changes OR to ||" do
          expect(described_class.run("cats OR cats")).to eq ["cats", "||", "cats"]
        end
      end

      it "breaks things into tokens split on whitespace" do
        expect(described_class.run("cats cats")).to eq ["cats", "cats"]
      end

      it "leaves single quoted strings as one token" do
        expect(described_class.run("name = 'cat herder'")).to eq ["name", "==", "'cat herder'"]
      end
    end
  end
end
