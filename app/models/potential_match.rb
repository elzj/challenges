class PotentialMatch < ApplicationRecord
  belongs_to :challenge_signup
  belongs_to :challenge

  serialize :matches, Array
end
