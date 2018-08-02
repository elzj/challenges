class ChallengeSignup < ApplicationRecord
  belongs_to :challenge
  belongs_to :user
  has_many :prompts, foreign_key: 'signup_id'
  has_many :potential_matches
  has_many :assignments,
    class_name: 'ChallengeAssignment',
    foreign_key: 'assignment_id'
  accepts_nested_attributes_for :prompts
  before_validation :set_prompt_data

  def set_prompt_data
    prompts.each do |prompt|
      prompt.user_id = user_id
      prompt.challenge_id = challenge_id
    end
  end

  def requests
    prompts.where(offer: false)
  end

  def offers
    prompts.where(offer: true)
  end

  def user_login
    user && user.login
  end

  def assigned_requests
    assign_join = "JOIN challenge_assignments ON challenge_assignments.signup_id = prompts.signup_id"
    Prompt.where(
             offer: false,
             challenge_assignments: {
               assignment_id: id
             }
            ).
           joins(assign_join)
  end
end
