class TournamentsController < ApplicationController

  def show
    @tournament = Tournament.find_by_slug(params[:slug])
    render "layouts/tournament.html.erb"
  end

  def create
    @tournament = Tournament.find_by_slug(params[:slug])
    current_user.tournaments<<@tournament
    flash[:added] = true
    redirect_to request.referrer
  end

  def destroy
    @tournament = Tournament.find_by_slug(params[:slug])
    current_user.tournaments.delete @tournament
    flash[:removed] = true
    redirect_to request.referrer
  end
end
