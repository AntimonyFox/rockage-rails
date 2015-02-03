class TournamentSerializer < ActiveModel::Serializer
  attributes :name, :slug

  has_one :bracket
end
