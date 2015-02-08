class BracketSerializer < ActiveModel::Serializer
  attributes :round_number, :num_descendants

  has_one :user
  has_many :brackets

  # def user
  #   t = object.tournament
  #   # if t.slug == "dash"
  #   #   newUser = User.create(username: object.user.username + object.user.partner.username)
  #   #   return newUser
  #   # else
  #   #   return object.user
  #   # end
  #   return object.user
  # end

end
