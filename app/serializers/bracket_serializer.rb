class BracketSerializer < ActiveModel::Serializer
  attributes :round_number, :num_descendants

  has_one :user
  has_many :brackets

  def user
    t = Tournament.find(tournament_id)
    if t.slug == "dash"
      return user.username + " & " + partner.username
    else
      return user.username
    end
  end

end
