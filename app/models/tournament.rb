class Tournament < ActiveRecord::Base
  has_many :entries
  has_many :users, :through => :entries
  has_many :waitlist_entries
  has_many :waitlisted_users, :through => :waitlist_entries, :source => :user

  has_many :brackets

  has_one :final_bracket
  has_one :bracket, :through => :final_bracket

  def running?
    return status == "running"
  end

  def complete?
    return status == "complete"
  end

  def self.all_valid
    return Tournament.all - Tournament.where(:status => "complete") - Tournament.where(:status => "disabled")

  end
end
