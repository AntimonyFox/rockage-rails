class Setting < ActiveRecord::Base
  validates :key, presence: true

  def self.get(key)
    return Setting.find_by_key(key).value
  end
end
