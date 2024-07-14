class ReactPhoto < ApplicationRecord
  belongs_to :user
  belongs_to :photo
  #VALIDATION
  #CALLBACK EVENTS
  before_destroy :handle_before_destroy
  before_save :handle_before_save

  def handle_before_destroy
    self.photo.update(numOfLikes: self.photo.numOfLikes - 1) if self.photo_id != nil
  end
  def handle_before_save
    self.photo.update(numOfLikes: self.photo.numOfLikes + 1) if self.photo_id != nil
  end
end