class Note < ActiveRecord::Base

  scope :search,->(search,user_id = nil) { 
    search_condition = "%" + search + "%"
    where('title LIKE ? OR body LIKE ?', search_condition, search_condition)
  } 
  scope :user_notes,->(user_id){
    userid_formatted = "%" + user_id + "%"
    where('user_id LIKE ?', userid_formatted)
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
