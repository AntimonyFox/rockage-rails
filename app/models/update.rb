class Update < ActiveRecord::Base
  validates :name, presence: true

  def self.touch(name)
    e = Update.find_by_name(name)
    if e.nil?
      e = Update.create(name: name)
    end
    e.touch
  end
end
