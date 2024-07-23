class UsersController < ApplicationController
    before_action :just_allow_admin, only: [:index,:edit]
    def index
        @pagy,@list_users = pagy(User.all)
    end
    def edit 
        @user = User.find(params[:id])
    end
    # def update
    #     @user = User.find(params[:id])
      
    #     if @user.update(user_params)
    #         set_my_flash_message 'User was successfully updated.', 'success'
    #         redirect_to "/"
            
    #     else 
    #         set_my_flash_message 'User was not updated.', 'error'
    #         redirect_to edit_user_path(@user)
    #     end
    # end
    def destroy
        @user = User.find(params[:id])
        if @user.destroy
            set_my_flash_message 'User was successfully deleted.', 'success'
            redirect_to "/photos"
        else
            set_my_flash_message 'User was not deleted.', 'error'
            redirect_to users_path
        end
    end
    private
    def user_params
        params.require(:user).permit(:firstName, :lastName, :email)
    end
end