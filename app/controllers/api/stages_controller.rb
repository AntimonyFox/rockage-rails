class Api::StagesController < ApplicationController

  def index
    e = Stage.all
    render json: e, root: false
  end

  def show
    e = Stage.find(params[:id])
    render json: e, root: false
  end
end
