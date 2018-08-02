class PromptMatcher
  TAG_BOOSTS = {
    'Fandom'        => 7,
    'Relationship'  => 5,
    'Character'     => 4,
    'Freeform'      => 1
  }.freeze

  def self.generate_matches(prompt, options = {})
    new(prompt, options).generate_matches
  end

  attr_reader :prompt, :options, :rules

  def initialize(prompt, options = {})
    @prompt = prompt
    @options = options
    @rules = options[:rules] || prompt.challenge&.rules || default_rules
  end

  def generate_matches
    results = Prompt.search(search_query)
    return [] unless results.dig('hits', 'total').to_i > 0
    results.dig('hits', 'hits').map do |hit|
      {
        prompt_id:       prompt.id,
        signup_id:       prompt.signup_id,
        user_id:         prompt.user_id,
        score:           hit['_score'],
        match_id:        hit['_id'],
        match_user_id:   hit['_source']['user_id'],
        match_signup_id: hit['_source']['signup_id']
      }
    end
  end

  def search_query
    tags = prompt.tags.group_by(&:type)
    musts = filter_terms(tags)
    shoulds = should_terms(tags)

    bool = {}
    bool[:should]   = shoulds unless shoulds.empty?
    bool[:filter]   = musts unless musts.empty?
    bool[:must_not] = exclude_terms

    query = { query: { bool: bool } }
  end

  # Don't match yourself
  def exclude_terms
    [
      { term: { user_id: prompt.user_id } }
    ]
  end

  def should_terms(tags)
    match_optional = rules[:optional_matchers] || []
    match_optional.map { |tag_type| 
      key = tag_type.downcase.pluralize
      next if tags[tag_type].blank?
      tags[tag_type].map { |tag| 
        {
          term: {
            "#{key}.id" => {
              value: tag.id,
              boost: TAG_BOOSTS[tag_type] || 1
            }
          }
        }
      }
    }.flatten.compact
  end

  def filter_terms(tags)
    matchers = rules[:required_matchers] || []
    is_offer = options[:prompt_type] == 'request' ? false : true
    musts = [{ term: { offer: is_offer } }] +
            matchers.map { |tag_type|
              key = tag_type.downcase.pluralize
              next if tags[tag_type].blank?
              { terms: { "#{key}.id" => tags[tag_type].map(&:id) } }
            }
    musts.flatten.compact
  end

  # With nothing else to go on, optionally map all the tags
  def default_rules
    { match_optional: Tag::TYPES }
  end
end
