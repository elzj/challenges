class Prompt < ApplicationRecord
  include Indexable
  include Taggable

  belongs_to :challenge
  belongs_to :user
  belongs_to :signup, class_name: 'ChallengeSignup', optional: true
  has_many :prompt_taggings
  has_many :tags, through: :prompt_taggings

  validates :body, presence: true
  validate :has_required_tags?

  def has_required_tags?
    tag_set = challenge && challenge.tag_sets.first
    PromptValidator.valid_tags?(self, tag_set)
  end

  def as_document
    tag_data = tags.inject({}) { |data, tag|
      key = tag.type.downcase.pluralize
      data[key] ||= []
      data[key] << { id: tag.id, name: tag.name }
      data
    }
    as_json.merge(tag_data)
  end

  def user_login
    user ? user.login : 'Nobody'
  end
end
