require 'rails_helper'

RSpec.describe PromptChallenge, type: :model do
  let(:challenge) { PromptChallenge.new }

  describe "#gift?" do
    it "should be false" do
      expect(challenge).not_to be_gift
    end
  end

  describe "#prompt?" do
    it "should be true" do
      expect(challenge).to be_prompt
    end
  end
end
