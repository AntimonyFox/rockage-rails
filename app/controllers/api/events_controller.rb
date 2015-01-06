class Api::EventsController < ApplicationController

  def index
    e = Event.all
    render json: e
  end

  def show
    e = Event.find(params[:id])
    render json: e, root: false
  end
end
