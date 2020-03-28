class ApplicationsController < ActionController::Base
  def index
    redirect_to new_link_path
  end
end
