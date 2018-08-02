class ChallengesController < ApplicationController
  def index
    @challenges = Challenge.order('created_at DESC')
  end

  def show
    @challenge = Challenge.find params[:id]
    @prompts = @challenge.prompts.includes(:tags, :user)
  end

  def new
    @challenge = Challenge.new()
    @collection = Collection.find params[:collection_id]
  end

  def edit
    @challenge = Challenge.find params[:id]
  end

  def create
    @challenge = Challenge.new(challenge_params)
    if @challenge.save
      if @challenge.gift?
        redirect_to edit_challenge_path(@challenge, stage: :rules)
      else
        redirect_to new_challenge_tag_set_path(@challenge)
      end
    else
      render :new
    end
  end

  def update
    @challenge = Challenge.find params[:id]
    if @challenge.update_attributes(challenge_params)
      redirect_to @challenge
    else
      render :edit
    end
  end

  def destroy
    @challenge = Challenge.find params[:id]
    @challenge.destroy
    redirect_to challenges_path
  end

  def challenge_params
    challenge_params = params.require('challenge').permit!
    challenge_params.merge(user_id: current_user.id)
  end
end
