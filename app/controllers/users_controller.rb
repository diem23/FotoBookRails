class UsersController < ApplicationController
    def edit 
        @user = User.find(params[:id])
    end
    def update
        @user = User.find(params[:id])
        #@user.update(user_params)
        @user.firstName = user_params[:firstName]
        @user.lastName = user_params[:lastName]
        @user.email = user_params[:email]
      
        if @user.update(user_params)
            redirect_to "/", notice: 'User was successfully updated.', type: 'success'
            
        else 
            render :edit, notice: 'User was not updated.', type: 'error'
        end
    end
    private
    def user_params
        params.require(:user).permit(:firstName, :lastName, :email)
    end
end