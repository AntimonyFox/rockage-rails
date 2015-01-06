class EventSerializer < ActiveModel::Serializer
  attributes :name, :when, :duration, :logo_url

  # belongs_to :stage

  # url [:stage, :event]
end
