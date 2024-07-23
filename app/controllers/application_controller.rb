class ApplicationController < ActionController::Base
     include Pagy::Backend
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

         def configure_permitted_parameters
              devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:firstName,:lastName, :email, :password)}
              devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:firstName,:lastName,:email, :password, :current_password, :password_confirmation)}
              devise_parameter_sanitizer.permit(:user) { |u| u.permit(:firstName,:lastName,:email, :profileImg)}
         end
     private
     def just_allow_admin
          if !user_signed_in? || current_user.isAdmin == false
               set_my_flash_message("You are not authorized to access this page", "error")
               redirect_to session[:failure_redirect] || users_path
          end
          
     end
     def just_allow_user
          if user_signed_in? && current_user.isAdmin 
               set_my_flash_message("You are not authorized to access this page", "error")
               redirect_to session[:failure_redirect] || root_path
          end
     end
     def set_my_flash_message(notice, type)
          flash[:notice] = notice
          flash[:type] = type
     end


end
