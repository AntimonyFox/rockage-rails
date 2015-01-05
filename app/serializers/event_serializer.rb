class EventSerializer < ActiveModel::Serializer
  attributes :name, :when, :logo_url

  # belongs_to :stage

  # url [:stage, :event]
end
