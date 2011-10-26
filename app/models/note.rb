class Note < ActiveRecord::Base
  validates :title,:body, :presence => true
  
  belongs_to :user

  paginates_per 6
  
end
