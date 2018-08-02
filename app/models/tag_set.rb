class TagSet < ApplicationRecord
  include Taggable

  belongs_to :challenge
  belongs_to :user
  has_many :set_taggings
  has_many :tags, through: :set_taggings

  def save_tags
    new_tags = Tag::TYPES.map{ |tag_type|
      list = send("#{tag_type.downcase}_names")
      Tag.process_list(tag_type, list)
    }
    new_tags.flatten.compact.each do |tag|
      set_taggings.create(tag_id: tag.id, user_id: user_id)
    end
  end
end
