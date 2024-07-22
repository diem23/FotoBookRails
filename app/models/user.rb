class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable, omniauth_providers: %i[facebook]                     
    ## authenticate by devise
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
    #ASSOCIATION
    has_many :albums, dependent: :destroy
    has_many :photos, dependent: :destroy
    has_many :active_relate, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
    has_many :passive_relate, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
    has_many :following, through: "active_relate", source: "followed"
    has_many :follower, through: "passive_relate", source: "follower"
    has_many :react_albums, dependent: :destroy
    has_many :reacted_albums, through: :react_albums, source: :album
    has_many :react_photos, dependent: :destroy
    has_many :reacted_photos, through: :react_photos, source: :photo
    #VALIDATION
    #validates :email, format: {with: /^[A_Za_z]+[A_Za_z0_9]*@[A_Za_z]+(.[A_Za_z]+)+$/}
    validates :email, format: {with: /\A[A-Za-z]+[A-Za-z0-9]*@[A-Za-z]+(.[A-Za-z]+)+\z/, message: "Your email format is invalid."}, length: {maximum: 255, message: "Must be 255 characters or less."}
    #validates :password,format: {with: /\A(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.* ).{,64}\z/, message: "must contain one digit, one lowercase letter, one uppercase letter, one special character, maximum 64 characters"}
    validates :firstName, :lastName, presence: true, length: {maximum: 25}
    validates :isActive, :isAdmin, inclusion: {in: [true, false]}
    #validates_associated :photos, :albums
    
    #CALLBACK EVENTS
    before_validation :handle_before_validation

    #IMPLEMENT CALLBACK FUNCTIONS
    def handle_before_validation
        self.isActive = true
        self.isAdmin = false
    end
end
