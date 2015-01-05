class Event < ActiveRecord::Base
  validates :name, :when, :stage, presence: true
end
