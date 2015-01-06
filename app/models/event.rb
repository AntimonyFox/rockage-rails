class Event < ActiveRecord::Base
  belongs_to :stage
  validates :name, presence: true
  validates :when, presence: true
  validates :duration, presence: true
  validates :stage, presence: true
end
