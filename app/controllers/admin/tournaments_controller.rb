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

      round_number = 1
      matches = []
      entries = @tournament.users.shuffle
      entries.each do |e|
        b = Bracket.new
        b.tournament = @tournament
        b.user = e
        b.round_number = round_number
        b.match_number = matches.size + 1
        b.save!
        matches<<b
      end

      matches2 = []
      while (matches.size > 1)
        while (!matches.empty?)
          b2 = Bracket.new
          b2.tournament = @tournament
          b2.round_number = round_number + 1
          b2.match_number = matches2.size + 1

          match1 = matches[0]
          matches.delete(match1)
          b2.brackets<<match1

          if (matches.size > 0)
            match2 = matches[0]
            matches.delete(match2)
            b2.brackets<<match2
          end

          b2.save!
          matches2<<b2
        end

        matches.clear
        matches = matches2.clone
        matches2.clear

        round_number += 1
      end

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

      @tournament.brackets.destroy_all

      @tournament.status = "cancelled"
      @tournament.save!
      redirect_to request.referrer
    end
  end
end
