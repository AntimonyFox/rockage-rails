class StageSerializer < ActiveModel::Serializer
  attributes :name

  has_many :events

  # url :stage
end
