class Setting < ActiveRecord::Base
  validates :key, presence: true

  def self.get(key)
    return Setting.find_by_key(key).value
  end

  def self.set(key, value)
    s = Setting.find_by_key(key)
    s.value = value
    s.save!
  end
end
