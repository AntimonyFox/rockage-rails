class TournamentsController < ApplicationController

  def show
    @tournament = Tournament.find_by_slug(params[:slug])
    render "layouts/tournament.html.erb"
  end

  def create
    @tournament = Tournament.find_by_slug(params[:slug])
    current_user.tournaments<<@tournament
    redirect_to request.referrer, flash: { added: true }
  end

  def destroy
    @tournament = Tournament.find_by_slug(params[:slug])
    current_user.tournaments.delete @tournament
    redirect_to request.referrer, flash: { removed: true }
  end
end
