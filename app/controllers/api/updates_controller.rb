class Api::UpdatesController < ApplicationController

  def index
    e = Update.all
    render json: e, root: false
  end

  def show
    e = Update.find_by_name(params[:name])
    render json: e, root: false
  end
end
