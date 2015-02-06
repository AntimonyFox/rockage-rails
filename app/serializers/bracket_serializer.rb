class BracketSerializer < ActiveModel::Serializer
  attributes :round_number, :num_descendants

  has_one :user
  has_many :brackets

end
