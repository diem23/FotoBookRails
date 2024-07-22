class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

         def configure_permitted_parameters
              devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:firstName,:lastName, :email, :password)}
              devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:firstName,:lastName,:email, :password, :current_password, :password_confirmation)}
              devise_parameter_sanitizer.permit(:user) { |u| u.permit(:firstName,:lastName,:email, :profileImg)}
         end

end
