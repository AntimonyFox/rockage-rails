class Tournament < ActiveRecord::Base
  has_many :entries
  has_many :users, :through => :entries
  has_many :waitlist_entries
  has_many :waitlisted_users, :through => :waitlist_entries, :source => :user
end
