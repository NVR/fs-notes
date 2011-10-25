class Note < ActiveRecord::Base
  validates :title,:body, :presence => true
  

end
