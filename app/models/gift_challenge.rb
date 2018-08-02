class GiftChallenge < Challenge
  store :rules, accessors: [
    :limited_to_set,    # are prompts limited to the tags in the set?
    :requests_required, # the number of requests required in a signup
    :requests_allowed,  # the number of requests allowed in a signup
    :offers_required,   # the number of offers required in a signup
    :offers_allowed,    # the number of offers allowed in a signup
    :required_matchers, # which tag types have to match between prompts
    :optional_matchers  # which tag types can be used to add relevance
  ]

  def self.model_name
    Challenge.model_name
  end

  def display_type
    'Gift Exchange'
  end

  def allowed_tag_types
    [required_matchers, optional_matchers].flatten.compact.uniq
  end
end
