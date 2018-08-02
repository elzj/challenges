class CollectionTagging < ApplicationRecord
  belongs_to :tag
  belongs_to :collection
end
