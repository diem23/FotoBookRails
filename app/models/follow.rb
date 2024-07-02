class Follow < ApplicationRecord
    belongs_to :follower , class_name: "User", foreign_key: true
    belongs_to :followed , class_name: "User", foreign_key: true
end
