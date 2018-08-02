class Collection < ApplicationRecord
  include Indexable
  include Taggable
  has_many :challenges
  has_many :collection_taggings
  has_many :tags, through: :collection_taggings
  belongs_to :user
end
