class Api::TagsController < ApplicationController
  def autocomplete
    tags = []
    options = {}
    if params[:type].present?
      options = { contexts: { typeContext: params[:type] }}
    end
    tags = Tag.suggest(
      params[:term], options
    ) if params[:term].present?
    data = tags.map{|tag| { label: tag, value: tag }}
    render json: data.to_json
  end
end
