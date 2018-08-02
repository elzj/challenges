class ChallengeAssignment < ApplicationRecord
  belongs_to :challenge
  belongs_to :user
  belongs_to :signup, class_name: 'ChallengeSignup'
  belongs_to :assignment, class_name: 'ChallengeSignup'

  def recipient_name
    ChallengeSignup.select("users.login AS user_name").
                    where(id: signup_id).
                    joins(:user).
                    first&.user_name
  end

  def assignee_name
    ChallengeSignup.select("users.login AS user_name").
                    where(id: assignment_id).
                    joins(:user).
                    first&.user_name
  end
end
