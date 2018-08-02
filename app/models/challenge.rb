class Challenge < ApplicationRecord
  store :rules, accessors: [:limited_to_set]

  belongs_to :user
  belongs_to :collection
  has_many :tag_sets
  has_many :prompts
  has_many :challenge_signups
  has_many :challenge_assignments
  has_many :potential_matches

  alias :signups :challenge_signups

  def gift?
    is_a?(GiftChallenge)
  end

  def prompt?
    is_a?(PromptChallenge)
  end

  def mod?(user)
    user && user.id == user_id
  end

  def display_type
    'Challenge'
  end

  def deadline_in_future?
    deadline && deadline > Time.now
  end
end
