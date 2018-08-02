class Tag < ApplicationRecord
  TYPES = %w(Rating Warning Category Fandom Relationship Character Freeform)
  include Indexable

  has_many :prompt_taggings
  has_many :prompts, through: :prompt_taggings
  has_many :set_taggings
  has_many :tag_sets, through: :set_taggings
  has_many :collection_taggings
  has_many :collections, through: :collection_taggings

  def self.process_list(type, list)
    names = list.split(',').map(&:strip).reject(&:empty?).uniq
    found = Tag.where(type: type, name: names).group_by(&:name)
    names.map do |name|
      found[name]&.first || Tag.create(type: type, name: name)
    end
  end

  def as_document
    {
      id: id,
      name: name,
      canonical: canonical,
      tag_type: type,
      suggest: {
        input: suggester_tokens,
        contexts: {
          typeContext: [
            type,
            canonical? ? "Canonical#{type}" : nil
          ].compact
        }
      }
    }
  end

  def suggester_tokens
    tokens = [name]
    # return tokens if !canonical?
    words = name.split(/[^\da-zA-Z]/)
    while words.length > 0
      words.shift
      next if words.first.nil? || words.first.length < 3
      tokens << words.join(" ").squish
    end
    tokens.uniq[0..19]
  end
end
