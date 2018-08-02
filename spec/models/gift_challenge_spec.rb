require 'rails_helper'

RSpec.describe GiftChallenge, type: :model do
  let(:challenge) { GiftChallenge.new }

  describe "#gift?" do
    it "should be true" do
      expect(challenge).to be_gift
    end
  end

  describe "#prompt?" do
    it "should be false" do
      expect(challenge).not_to be_prompt
    end
  end

  describe "#rules" do
    it "allows us to set rules" do
      challenge.num_offers = 10
      expect(challenge.num_offers).to eq(10)
    end
  end
end
