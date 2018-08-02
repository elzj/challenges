require 'rails_helper'

RSpec.describe PromptValidator, type: :model do
  describe '#valid?' do
    let(:challenge) { PromptChallenge.new(id: 81) }
    let(:prompt) { challenge.prompts.build }
    let(:tag_set) { TagSet.new }
    let(:tags) do
      [
        Character.new(name: "Godzilla"),
        Character.new(name: "Mothra"),
        Character.new(name: "Kong")
      ]
    end

    context "with no tag set" do
      it "should return true" do
        validator = PromptValidator.new(prompt, nil)
        expect(validator.valid?).to be_truthy
      end
    end

    context "with tags and an empty tag set" do
      before do
        prompt.tags = tags
      end

      it "should be valid" do
        validator = PromptValidator.new(prompt, tag_set)
        expect(validator.valid?).to be_truthy
      end
    end

    context "without strict matching" do
      before do
        prompt.challenge.limited_to_set = false
      end

      it "can't be empty when tags are specified" do
        prompt.tags = []
        tag_set.tags = [tags.last]

        validator = PromptValidator.new(prompt, tag_set)
        expect(validator.valid?).to be_falsey
      end

      it "must contain at least one tag in the set" do
        prompt.tags = [tags.first]
        tag_set.tags = [tags.last]

        validator = PromptValidator.new(prompt, tag_set)
        expect(validator.valid?).to be_falsey
      end

      it "may contain more tags than the set" do
        prompt.tags = tags
        tag_set.tags = tags[0..1]

        validator = PromptValidator.new(prompt, tag_set)
        expect(validator.valid?).to be_truthy        
      end
    end

    context "with strict matching" do
      before do
        prompt.challenge.limited_to_set = true
      end

      it "must contain at least one tag in the set" do
        prompt.tags = [tags.first]
        tag_set.tags = [tags.last]

        validator = PromptValidator.new(prompt, tag_set)
        expect(validator.valid?).to be_falsey
      end

      it "must not contain tags outside the set" do
        prompt.tags = tags
        tag_set.tags = tags[0..1]

        validator = PromptValidator.new(prompt, tag_set)
        expect(validator.valid?).to be_falsey
      end

      it "may contain one tag from the set" do
        prompt.tags = [tags.first]
        tag_set.tags = tags

        validator = PromptValidator.new(prompt, tag_set)
        expect(validator.valid?).to be_truthy        
      end
    end
  end
end
