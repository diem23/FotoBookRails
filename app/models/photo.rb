require 'carrierwave/orm/activerecord'
class Photo < ApplicationRecord
    mount_uploader :image, PhotoUploader
    #ASSOCIATION
    belongs_to :user
    belongs_to :album, optional: true
    has_many :react_photos, dependent: :destroy
    has_many :reacting_users, through: :react_photos, source: :user
    #VALIDATION
    validates :title, length: {maximum: 140}
    validates :description, length: {maximum: 300}
    validates :isPrivate, inclusion: {in: [true, false]}
    validates :image, presence: true
    validates :numOfLikes, numericality: { only_integer: true , message: "Must be an integer"}
    #SCOPES
    scope :public_photos, -> { where(isPrivate: false) }
    scope :private_photos, -> { where(isPrivate: true) }
    #CALLBACK EVENTS
    before_validation :handle_before_validation
    before_destroy :handle_before_destroy
    before_save :handle_before_save
    def handle_before_validation
        self.numOfLikes=0 if self.numOfLikes == nil
        self.isPrivate=true if isPrivate == nil
    end
    def handle_before_destroy
        self.album.update(numOfPhotos: self.album.numOfPhotos - 1) if self.album_id != nil
    end
    def handle_before_save
        self.album.update(numOfPhotos: self.album.numOfPhotos + 1) if self.album_id != nil
    end
    
end