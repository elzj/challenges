class Work < ApplicationRecord
  belongs_to :user
  belongs_to :prompt, counter_cache: true
  validates :title, presence: true
  validates :body, presence: true
end
