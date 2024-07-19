class ReactPhoto < ApplicationRecord
  belongs_to :user
  belongs_to :photo
  #VALIDATION
  #CALLBACK EVENTS
  before_destroy :handle_before_destroy
  before_save :handle_before_save

  def handle_before_destroy
    puts "handle_before_destroy react_photo"
    self.photo.update(numOfLikes: self.photo.numOfLikes - 1)
    
    puts self.photo_id, "photo_id"
    puts self.photo.numOfLikes, "numOfLikes"
  end
  def handle_before_save
    puts "handle_before_save react_photo"
    self.photo.update(numOfLikes: self.photo.numOfLikes + 1)
    
    puts self.photo_id, "photo_id"
    puts self.photo.numOfLikes, "numOfLikes"
  end
end