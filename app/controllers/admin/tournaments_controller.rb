class Admin::TournamentsController < ApplicationController

  def index
    if !admin_user_signed_in?
      session[:return_to] ||= request.referrer
      redirect_to new_admin_user_session_path
    else
      @tournaments = Tournament.all
      render "layouts/admin/tournament_list.html.erb"
    end
  end

  def show
    if !admin_user_signed_in?
      session[:return_to] ||= request.referrer
      redirect_to new_admin_user_session_path
    else
      @tournament = Tournament.find_by_slug(params[:slug])
      render "layouts/admin/tournament.html.erb"
    end
  end

  def start
    if !admin_user_signed_in?
      session[:return_to] ||= request.referrer
      redirect_to new_admin_user_session_path
    else
      @tournament = Tournament.find_by_slug(params[:slug])
      @tournament.status = "running"
      @tournament.save!
      redirect_to request.referrer
    end
  end

  def cancel
    if !admin_user_signed_in?
      session[:return_to] ||= request.referrer
      redirect_to new_admin_user_session_path
    else
      @tournament = Tournament.find_by_slug(params[:slug])
      @tournament.status = "cancelled"
      @tournament.save!
      redirect_to request.referrer
    end
  end
end
