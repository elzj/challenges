class PromptValidator

  def self.valid_tags?(prompt, tag_set)
    new(prompt, tag_set).valid?
  end

  attr_reader :prompt, :tag_set
  def initialize(prompt, tag_set)
    @prompt = prompt
    @tag_set = tag_set
  end

  def valid?
    return true if tag_set.nil?
    limit_to_set? ? exact_match? : subset_match?
  end

  # If there are tags specified for a type, then this prompt
  # can't contain anything else
  def exact_match?
    determine_match do |tagged, required|
      tagged.present? && (tagged - required).empty?
    end
  end

  # If there are tags specified for a type, then this prompt
  # needs to include at least one of them
  def subset_match?
    determine_match do |tagged, required|
      (tagged & required).present?
    end
  end

  def determine_match
    is_valid = true
    Tag::TYPES.each do |tag_type|
      required = set_tags[tag_type]
      tagged = prompt_tags[tag_type] || []
      next unless required.present?
      good = yield(tagged, required)
      is_valid = false unless good
    end
    is_valid
  end

  # Check the challenge rules to see how strictly we're matching
  def limit_to_set?
    prompt.challenge.respond_to?(:limited_to_set) &&
      prompt.challenge.limited_to_set
  end

  def set_tags
    @set_tags ||= tag_set.tags.group_by(&:type)
  end

  def prompt_tags
    @prompt_tags ||= prompt.tags.group_by(&:type)
  end
end