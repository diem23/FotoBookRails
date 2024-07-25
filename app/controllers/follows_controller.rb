class FollowsController < ApplicationController
    before_action :handle_before_action
    def create
        follow=current_user.active_relate.new(followed_id: @user.id)
        follow.save
    end
    def destroy
        follow = Follow.find_by(follower_id: current_user.id, followed_id: @user.id)
        follow.destroy
    end

    def followings
        @resources = @user.following
    end

    def followers
        @resources = @user.follower
    end
    def follow_button
        render partial: "shared/follow_button", locals: {id: @user.id}
    end
    def unfollow_button
        render partial: "shared/unfollow_button", locals: {id: @user.id}
    end
    private
    def handle_before_action
        @user = User.find(params[:user_id])
        @list_followings = current_user.following.pluck(:id)
    end
end