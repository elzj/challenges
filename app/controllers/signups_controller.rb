class SignupsController < ApplicationController
  before_action :load_challenge

  def index
    @signups = ChallengeSignup.where(challenge_id: @challenge.id)
  end

  def show
    @signup = ChallengeSignup.find params[:id]
  end

  def new
    @signup = ChallengeSignup.new
    if @challenge.requests_required
      @challenge.requests_required.times { @signup.prompts.build(offer: false) }
    end
    if @challenge.offers_required
      @challenge.offers_required.times { @signup.prompts.build(offer: true) }
    end    
  end

  def edit
    @signup = ChallengeSignup.find params[:id]
  end

  def create
    @signup = ChallengeSignup.new(signup_params)
    byebug
    if @signup.save
      redirect_to challenge_signup_path(@challenge, @signup)
    else
      render :new
    end
  end

  def update
    @signup = ChallengeSignup.find params[:id]
    if @signup.update_attributes(signup_params)
      redirect_to challenge_signup_path(@challenge, @signup)
    else
      render :edit
    end
  end

  def destroy
    @signup = ChallengeSignup.find params[:id]
    @signup.destroy
    redirect_to challenge_signups_path(@challenge)
  end

  def load_challenge
    @challenge = Challenge.find params[:challenge_id]
  end

  def signup_params
    sps = params.require(:challenge_signup).permit!
    sps.merge(challenge_id: @challenge.id, user_id: current_user.id)
  end
end
