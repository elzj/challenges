class TagSetsController < ApplicationController
  before_action :load_challenge
  before_action :verify_access, except: [:index, :show]

  def index
    @tag_sets = @challenge.tag_sets
  end

  def show
    @tag_set = @challenge.tag_sets.find params[:id]
  end

  def new
    @tag_set = @challenge.tag_sets.build
  end

  def edit
    @tag_set = @challenge.tag_sets.find params[:id]
  end

  def create
    @tag_set = @challenge.tag_sets.build(tag_set_params)
    if @tag_set.save
      redirect_to challenge_tag_set_path(@challenge, @tag_set)
    else
      render :new
    end
  end

  def update
    @tag_set = @challenge.tag_sets.find params[:id]
    if @tag_set.update_attributes(collection_params)
      redirect_to challenge_tag_set_path(@challenge, @tag_set)
    else
      render :edit
    end
  end

  def destroy
    @tag_set = @challenge.tag_sets.find params[:id]
    @tag_set.destroy
    redirect_to @challenge
  end

  private

  def verify_access
    @challenge.mod?(current_user) || access_denied
  end

  def tag_set_params
    ts_params = params.require(:tag_set).permit!
    ts_params.merge(
      challenge_id: @challenge.id,
      user_id: current_user.id
    )
  end

  def load_challenge
    @challenge = Challenge.find params[:challenge_id]
  end
end
