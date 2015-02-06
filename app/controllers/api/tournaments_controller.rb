class Api::TournamentsController < ApplicationController

  def index
    mode = Setting.get(:mode)
    if mode == "brackets"
      e = Tournament.find_by_slug(Setting.get(:disp_tourn))
    elsif mode == "nextup"
      t = Tournament.find_by_slug(Setting.get(:disp_tourn))
      e = Bracket.where(round_number: t.current_round)
    else
      e = Tournament.all
    end

    render json: e, root: mode

  end

  def show
    e = Tournament.find_by_slug(params[:slug])
    render json: e, root: false
  end
end
