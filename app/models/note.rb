class Note < ActiveRecord::Base
  PER_PAGE = 9
  validates :title,:body, :presence => true
  
  belongs_to :user

  paginates_per PER_PAGE

  def self.pages_count
    self.count / PER_PAGE + 1
  end

end
