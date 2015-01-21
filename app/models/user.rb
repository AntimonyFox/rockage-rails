class User < ActiveRecord::Base
  include Gravtastic
  gravtastic

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :entries
  has_many :tournaments, :through => :entries
  has_many :waitlist_entries
  has_many :waitlisted_tournaments, :through => :waitlist_entries, :source => :tournament

  def has_tournament?(t)
    return self.tournaments.include? t
  end

  def is_waitlisted_for?(t)
    return self.waitlisted_tournaments.include? t
  end

  validates_uniqueness_of :username
end
