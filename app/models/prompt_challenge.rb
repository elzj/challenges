class PromptChallenge < Challenge
  def self.model_name; Challenge.model_name; end

  def display_type
    'Prompt Challenge'
  end
end
