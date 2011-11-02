class Note < ActiveRecord::Base
  PER_PAGE = 8
  validates :title,:body, :presence => true
  
  belongs_to :user

  paginates_per PER_PAGE

  def self.pages_count
    self.count / PER_PAGE + 1
  end
  
  def self.search(search)
    search_condition = "%" + search + "%"
    find(:all, :conditions => ['title LIKE ? OR body LIKE ?', search_condition, search_condition])
  end

end
