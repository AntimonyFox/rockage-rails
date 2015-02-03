class BracketSerializer < ActiveModel::Serializer
  attributes

  has_one :user
  has_many :brackets
end
