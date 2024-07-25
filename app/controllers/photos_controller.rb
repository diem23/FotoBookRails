class PhotosController < ApplicationController
    Pagy::DEFAULT[:limit] = 10
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :index]
    before_action :just_allow_user, only: [:new, :create, :feed,:discover, :index]
    before_action :before_action_handle1, only: [:feed, :discover]
    before_action :get_resource, only: [:edit, :update, :destroy]
    before_action :get_user, only: [:index, :new]
    def discover
        @pagy,@resources = pagy(Photo.is_public.includes(:user))
    end
    def feed
        @resources = []
        if user_signed_in?
            @pagy,@resources = pagy(Photo.where(user_id: @list_followings).where(isPrivate: false).includes(:user).order('created_at DESC'))
        end
    end
    def index
        @viewing_current_user = @user.id == current_user.id
        @resources = @user.photos
        @resources = @resources.is_public if !@viewing_current_user
    end
    def new
        @resource = Photo.new
    end
    def create
        new_photo_params = photo_params.dup
        new_photo_params[:isPrivate] = new_photo_params[:isPrivate] == "1"
        resource = current_user.photos.new(new_photo_params)
        if resource.save
            set_my_flash_message("Photo was successfully created.", "success")
            redirect_to session[:success_redirect] || root_path
        else
            set_my_flash_message("Photo was not created.", "error")
            render :new
        end
    end
    def edit
    end
    def update
        if @resource.update(photo_params)
            set_my_flash_message("Photo was successfully updated.", "success")
            
            redirect_to session[:success_redirect] || root_path
        else 
            set_my_flash_message("Photo was not updated.", "error")
            render :edit
        end
    end
    def destroy
        if @resource.destroy
            set_my_flash_message("Photo was successfully deleted.", "success")
            redirect_to session[:success_redirect] || root_path
        else
            set_my_flash_message("Photo was not deleted.", "error")
            render :edit
        end
    end
    private
    def before_action_handle1
        @list_reacted_photos = []
        @list_reacted_photos = current_user.reacted_photos.pluck(:id) if user_signed_in?
        @list_followings = []
        @list_followings = current_user.following.pluck(:id) if user_signed_in?
    end
    def get_resource
        @resource = Photo.find params[:id]
    end
    def get_user
        @user = User.find params[:user_id]
    end
    def photo_params
        params.require(:photo).permit(:title, :description, :isPrivate, :image)
    end
    
end