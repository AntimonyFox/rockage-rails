class Api::EventsController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def index
    e = Event.all
    render json: e
  end

  def show
    e = Event.find(params[:id])
    render json: e, root: false
  end
end
