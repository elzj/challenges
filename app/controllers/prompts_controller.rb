class PromptsController < ApplicationController
  def index
    @prompts = Prompt.order('created_at DESC')
  end

  def show
    @prompt = Prompt.find params[:id]
  end

  def new
    @prompt = Prompt.new
  end

  def edit
    @prompt = Prompt.find params[:id]
  end

  def create
    @prompt = Prompt.new(prompt_params)
    if @prompt.save
      redirect_to @prompt
    else
      render :new
    end
  end

  def update
    @prompt = Prompt.find params[:id]
    if @prompt.update_attributes(prompt_params)
      redirect_to @prompt
    else
      render :edit
    end
  end

  def destroy
    @prompt = Prompt.find params[:id]
    @prompt.destroy
    redirect_to prompts_path
  end

  def prompt_params
    prompt_params = params.require('prompt').permit!
    prompt_params.merge(user_id: current_user.id)
  end
end

