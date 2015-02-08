class Admin::TournamentsController < ApplicationController

  def index
    if !admin_user_signed_in?
      session[:return_to] ||= request.referrer
      redirect_to new_admin_user_session_path
    else
      @tournaments = Tournament.all
      @tournaments = @tournaments.sort_by { |t| t.name.downcase }
      render "layouts/admin/tournament_list.html.erb"
    end
  end

  def show_quadrants
    if !admin_user_signed_in?
      session[:return_to] ||= request.referrer
      redirect_to new_admin_user_session_path
    else
      Setting.set("mode", "quadrants")
      Update.touch("tournaments")

      redirect_to admin_tournaments_path
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

  def match
    if !admin_user_signed_in?
      session[:return_to] ||= request.referrer
      redirect_to new_admin_user_session_path
    else
      @tournament = Tournament.find_by_slug(params[:slug])
      @tournament.current_match = params[:match]
      @tournament.current_round = params[:round]
      @tournament.save!
      @match = @tournament.brackets.where(:round_number => params[:round], :match_number => params[:match]).take
      @users = @match.users.sort_by { |obj| (@match.brackets & obj.brackets)[0].id }
      render "layouts/admin/tournament_match.html.erb"
    end
  end

  def call_match
    if !admin_user_signed_in?
      session[:return_to] ||= request.referrer
      redirect_to new_admin_user_session_path
    else
      @tournament = Tournament.find_by_slug(params[:slug])
      # @tournament = Tournament.find_by_slug(Setting.get("disp_tourn"))

      Setting.set("mode", "nextup")
      Setting.set("disp_tourn", params[:slug])
      Update.touch("tournaments")

      redirect_to admin_tournament_match_path(@tournament.slug, @tournament.current_round, @tournament.current_match)
    end
  end

  def start_match
    if !admin_user_signed_in?
      session[:return_to] ||= request.referrer
      redirect_to new_admin_user_session_path
    else
      @tournament = Tournament.find_by_slug(params[:slug])

      Setting.set("mode", "brackets")
      Setting.set("disp_tourn", params[:slug])
      Update.touch("tournaments")

      redirect_to admin_tournament_match_path(@tournament.slug, @tournament.current_round, @tournament.current_match)
    end
  end

  def match_result
    if !admin_user_signed_in?
      session[:return_to] ||= request.referrer
      redirect_to new_admin_user_session_path
    else
      Update.touch("tournaments")

      @tournament = Tournament.find_by_slug(params[:slug])
      @match = @tournament.brackets.where(:round_number => params[:round], :match_number => params[:match])[0]
      if !@match.nil?
        modification = !@match.user.nil?
        @match.user = User.find(params[:user_id])
        @match.save!

        next_match = (modification) ? @match : @match.next_bracket
        if !next_match.nil?
          @tournament.current_round = next_match.round_number
          @tournament.current_match = next_match.match_number
          @tournament.save!
          redirect_to admin_tournament_match_path(@tournament.slug, @tournament.current_round, @tournament.current_match)
        else
          if @tournament.bracket.user
            @tournament.status = "complete"
            @tournament.current_round = 1
            @tournament.current_match = 1
            @tournament.save!
          end
          redirect_to admin_show_tournament_path(@tournament.slug)
        end
      end
    end
  end

  def start
    if !admin_user_signed_in?
      session[:return_to] ||= request.referrer
      redirect_to new_admin_user_session_path
    else
      Setting.set("mode", "brackets")
      Setting.set("disp_tourn", params[:slug])
      Update.touch("tournaments")
      @tournament = Tournament.find_by_slug(params[:slug])

      round_number = 0
      matches = []
      entries = @tournament.users.shuffle

      if params[:slug] == "dash"
        leaders = []
        entries.each do |e|
          if e.partner
            leaders << e
            entries.delete(e)
            entries.delete(e.partner)
          end
        end

        shouldP1 = true
        p1 = []
        p2 = []
        entries.each do |e|
          if shouldP1
            p1 << e
          else
            p2 << e
          end
          shouldP1 ^= true
        end

        save = nil
        if p1.count > p2.count
          save = p1[0]
          p1.delete(save)
        end

        p1.each do |p|
          q = p2[0]
          p2.delete(q)
          p.partner = q
          q.partner = p

          leaders << p
        end

        if save.nil?
          leaders << save
        end

        entries.clear
        entries = leaders

      end

      entries.each do |e|
        b = Bracket.new
        b.tournament = @tournament
        b.user = e
        b.round_number = round_number
        b.match_number = matches.size + 1
        b.num_descendants = 1
        b.save!
        matches<<b
      end

      goingUp = false
      bye = false
      matches2 = []
      while (matches.size > 1)
        if goingUp
          if matches.count % 2 == 1
            bye = true
          end
        end

        while (!matches.empty?)
          b2 = Bracket.new
          b2.tournament = @tournament
          b2.round_number = round_number + 1
          b2.match_number = matches2.size + 1

          match1 = matches[0]
          matches.delete(match1)
          b2.brackets<<match1
          num_descendants = match1.num_descendants

          if (matches.size > 0 and !bye)
            match2 = matches[0]
            matches.delete(match2)
            b2.brackets<<match2
            num_descendants += match2.num_descendants
          end
          bye = false

          b2.num_descendants = num_descendants
          b2.save!
          matches2<<b2
        end

        matches.clear
        matches = matches2.clone
        matches2.clear

        goingUp ^= true

        round_number += 1
      end

      @tournament.bracket = matches[0]
      @tournament.current_round = 1
      @tournament.current_match = 1

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
      Update.touch("tournaments")
      @tournament = Tournament.find_by_slug(params[:slug])

      @tournament.brackets.destroy_all

      @tournament.status = "cancelled"
      @tournament.save!
      redirect_to request.referrer
    end
  end
end
