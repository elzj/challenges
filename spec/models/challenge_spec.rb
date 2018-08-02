require 'rails_helper'

RSpec.describe Challenge, type: :model do
  let(:challenge) { Challenge.new }

  describe "#mod?" do
    it "should return false when the user is nil" do
      challenge.user_id = 5
      expect(challenge.mod?(nil)).to be_falsey
    end

    it "should return true when the user is the challenge owner" do
      challenge.user_id = 5
      u = User.new(id: 5)
      expect(challenge.mod?(u)).to be_truthy
    end
  end

  describe "#gift?" do
    it "should be false by default" do
      expect(challenge).not_to be_gift
    end
  end

  describe "#prompt?" do
    it "should be false by default" do
      expect(challenge).not_to be_prompt
    end
  end
end
