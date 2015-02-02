class Standing < ActiveRecord::Base
  belongs_to :bracket
  belongs_to :user

end
