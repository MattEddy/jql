require "json_q_l/condition"

module JsonQL
  describe Condition do
    let(:test_json) do
      JSON.parse(File.read(File.dirname(__FILE__) + '/../fixtures/events.json'))['events'].first
    end

    describe ".create_from_tokens" do
      context "returns true if condition is met" do
        it "works if the columns name is one the left" do
          expect(described_class
            .create_from_tokens(["invited_count", ">", "110"])
            .call(test_json)).to be_truthy
        end

        it "works if the columns name is one the right" do
          expect(described_class
            .create_from_tokens(["110", "<", "invited_count"])
            .call(test_json)).to be_truthy
        end
      end

      context "returns false if condition is not met" do
        it "works if the columns name is one the right" do
          expect(described_class
            .create_from_tokens(["130", "<", "invited_count"])
            .call(test_json)).to be_falsey
        end

        it "works if the columns name is one the left" do
          expect(described_class
            .create_from_tokens(["invited_count", ">", "130"])
            .call(test_json)).to be_falsey
        end
      end

      it "is truthy if both conditions are compared and should be true" do
        expect(described_class
          .create_from_tokens(["invited_count", "<", "121", "&&", "2015", "==", "year"])
          .call(test_json)).to be_truthy
      end

      it "is falsey if both conditions are compared and should be false" do
        expect(described_class
          .create_from_tokens(["invited_count", "<", "120", "&&", "2015", "==", "year"])
          .call(test_json)).to be_falsey
      end

      it "is falsey if both conditions are compared and should be false" do
        expect(described_class
          .create_from_tokens(["invited_count", "<", "121", "&&", "2016", "==", "year"])
          .call(test_json)).to be_falsey
      end
    end
  end
end

