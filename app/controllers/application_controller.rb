class ApplicationController < ActionController::Base
  def access_denied
    flash[:error] = "Nope"
    redirect_to root_path
  end
end
