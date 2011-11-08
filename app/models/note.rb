class Note < ActiveRecord::Base

  scope :search,->(search) { 
    search_condition = "%" + search + "%"
    where('title LIKE ? OR body LIKE ?', search_condition, search_condition)
  } 

  PER_PAGE = 9

  validates :title,:body, :presence => true
  
  belongs_to :user

  has_and_belongs_to_many :topics

  paginates_per PER_PAGE

  def self.pages_count
    self.count / PER_PAGE + 1
  end

end
