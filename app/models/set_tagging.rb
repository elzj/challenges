class SetTagging < ApplicationRecord
  belongs_to :tag
  belongs_to :tag_set
  belongs_to :user
end
