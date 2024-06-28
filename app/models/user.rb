class User < ApplicationRecord
    has_many :active_relate, class_name: "Relationship", foreign_key: "follower_id", dependent: "destroy",
    has_many :passive_relate, class_name: "Relationship", foreign_key: "followed_id", dependent: "destroy",
    has_many :following, through: "active_relate", source: "followed"
    has_mamne :follower, through: "passive_relate", source: "follower"
end
