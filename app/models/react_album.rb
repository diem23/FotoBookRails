class ReactAlbum < ApplicationRecord
  belongs_to :user
  belongs_to :album
  #VALIDATION
  #CALLBACK EVENTS
  before_destroy :handle_before_destroy
  before_save :handle_before_save
  def handle_before_destroy
    self.album.update(numOfLikes: self.album.numOfLikes - 1) if self.album_id != nil
  end
  def handle_before_save
    self.album.update(numOfLikes: self.album.numOfLikes + 1) if self.album_id != nil
  end
end