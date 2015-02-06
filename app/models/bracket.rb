class Bracket < ActiveRecord::Base
  belongs_to :tournament

  belongs_to :bracket
  has_many :brackets

  has_one :standing
  has_one :user, :through => :standing

  has_many :users, :through => :brackets

  def next_bracket
    next_bracket = self.tournament.brackets.where(:round_number => round_number, :match_number => match_number + 1)[0]
    next_bracket = self.tournament.brackets.where(:round_number => round_number + 1, :match_number => 1)[0] if next_bracket.nil?
    return next_bracket
  end

  def next_round
    next_round = self.bracket
    return next_round
  end

  def prev_round
    prev_round = self.tournament.brackets.where(:round_number => round_number - 1, :match_number => 1)[0] if round_number - 1 > 0
    return prev_round
  end

  def next_match
    next_match = self.tournament.brackets.where(:round_number => round_number, :match_number => match_number + 1)[0]
    return next_match
  end

  def prev_match
    prev_match = self.tournament.brackets.where(:round_number => round_number, :match_number => match_number - 1)[0]
    return prev_match
  end

end
