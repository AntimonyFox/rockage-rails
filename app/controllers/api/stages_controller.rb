class Api::StagesController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def index
    e = Stage.all
    render json: e, root: "schedule"
  end

  def show
    e = Stage.find(params[:id])
    render json: e, root: false
  end
end
