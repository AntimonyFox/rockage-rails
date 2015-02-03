class Api::TournamentsController < ApplicationController

  def index
    e = Tournament.all
    render json: e, root: false
  end

  def show
    e = Tournament.find_by_slug(params[:slug])
    render json: e, root: false
  end
end
