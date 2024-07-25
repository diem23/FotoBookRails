class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :just_allow_user
    before_action :handle_before_action
    def show
        @viewing_current_user = @user.id == current_user.id
        @resources = @user.photos 
        @resources = @resources.is_public if !@viewing_current_user
    end
    def index
    end
    private
        def user_params
            params.require(:user).permit(:firstName, :lastName, :email)
        end
        def handle_before_action
            @user = User.find(params[:id])
            @list_followings = current_user.following.pluck(:id)
        end
end