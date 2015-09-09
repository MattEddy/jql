require "json_q_l/condition"

module JsonQL
  describe Condition do
    describe ".create_from_tokens" do
      context "returns a condtition (proc) that returns true if met" do
        condition = described_class.create_from_tokens(["age", ">", "3"])["age"]

        it "returns true if condition is met" do
          expect(condition.call(4)).to be_truthy
        end

        it "returns false if condition is not met" do
          expect(condition.call(0)).to be_falsey
        end
      end
    end
  end
end

