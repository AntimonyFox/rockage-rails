class Bracket < ActiveRecord::Base
  belongs_to :tournament

  belongs_to :bracket
  has_many :brackets

  has_one :standing
  has_one :user, :through => :standing

end
