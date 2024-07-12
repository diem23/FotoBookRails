class Album < ApplicationRecord
    has_many :photos, dependent: :destroy, before_add: :handle_before_add
    belongs_to :user
    has_many :react_albums, dependent: :destroy
    has_many :reacted_users, through: :react_albums, source: :user
    #VALIDATION
    validates_associated :photos
    validates :isPrivate, inclusion: { in: [true, false], message:"Must be a boolean"}
    validates :numOfPhotos, numericality: { only_integer: true , less_than_or_equal_to: 25, message: "Must be an integer less than 25"}
    validates :numOfLikes, numericality: { only_integer: true , message: "Must be an integer"}
    #SCOPES
    scope :public_albums, -> { where(isPrivate: false) }
    scope :private_albums, -> { where(isPrivate: true) }
    #CALLBACK
    before_validation :handle_before_validate

    def handle_before_validate
        self.numOfLikes=0 if self.numOfLikes == nil
        self.numOfPhotos=0 if self.numOfPhotos == nil
        self.isPrivate=true if self.isPrivate == nil
    end
    def handle_before_add(photo)
        photo.user_id = self.user_id
    end
    
end
