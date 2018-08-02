class AssignmentsController < ApplicationController
  before_action :load_challenge

  def index
    @assignments = ChallengeAssignment.where(challenge_id: @challenge.id)
  end

  def load_challenge
    @challenge = Challenge.find params[:challenge_id]
  end
end
