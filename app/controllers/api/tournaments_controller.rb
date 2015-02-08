class Api::TournamentsController < ApplicationController

  def index
    mode = Setting.get(:mode)
    if mode == "brackets"
      e = Tournament.find_by_slug(Setting.get(:disp_tourn))
    elsif mode == "nextup"
      t = Tournament.find_by_slug(Setting.get(:disp_tourn))
      e = t.brackets.where(round_number: t.current_round, match_number: t.current_match)
    else
      # e = Tournament.all
      e = []

      e << Tournament.find_by_slug(Setting.get("quad1")) if Setting.get("quad1")
      e << Tournament.find_by_slug(Setting.get("quad2")) if Setting.get("quad2")
      e << Tournament.find_by_slug(Setting.get("quad3")) if Setting.get("quad3")
      e << Tournament.find_by_slug(Setting.get("quad4")) if Setting.get("quad4")
    end

    render json: e, root: mode

  end

  def show
    e = Tournament.find_by_slug(params[:slug])
    render json: e, root: false
  end
end
