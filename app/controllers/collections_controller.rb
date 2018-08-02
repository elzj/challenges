class CollectionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @collections = Collection.order('collections.created_at DESC').includes(:tags)
    @active_challenges = Challenge.where(
                            collection_id: @collections.pluck(:id),
                          ).group_by(&:collection_id)
  end

  def show
    @collection = Collection.find params[:id]
  end

  def new
    @collection = Collection.new
  end

  def edit
    @collection = Collection.find params[:id]
  end

  def create
    @collection = Collection.new(collection_params)
    if @collection.save
      redirect_to @collection
    else
      render :new
    end
  end

  def update
    @collection = Collection.find params[:id]
    if @collection.update_attributes(collection_params)
      redirect_to @collection
    else
      render :edit
    end
  end

  def destroy
    @collection = Collection.find params[:id]
  end

  def collection_params
    params.require(:collection).permit(
      :name,
      :description,
      :fandom_names,
      :relationship_names,
      :character_names,
      :freeform_names
    ).merge(user_id: current_user.id)
  end
end
