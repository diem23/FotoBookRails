class AlbumsController < ApplicationController
    Pagy::DEFAULT[:limit] = 10
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :index]
    before_action :just_allow_user, only: [:new, :create,:new, :feed,:discover, :index]
    before_action :before_action_handle1, only: [:feed, :discover]
    before_action :get_resource, only: [  :edit, :update, :destroy]
    before_action :get_user, only: [:index, :new]
    def feed
        @resources = []
        if user_signed_in?
            @pagy,@resources = pagy(Album.where(user_id: @list_followings).where(isPrivate: false).includes(:user).order('created_at DESC'))
        end
    end
    def discover
        @pagy,@resources = pagy(Album.is_public.includes(:user))
    end
    def index
        @viewing_current_user = @user.id == current_user.id
        @resources = @user.albums
        @resources = @resources.is_public if !@viewing_current_user
    end

    def create
        
        new_album_params = album_params.dup
        new_album_params[:photos_attributes].delete("0")
        resource =  current_user.albums.new(new_album_params)
        resource.photos.each do |photo|
            photo.user_id = resource.user_id
            photo.isPrivate = resource.isPrivate 
        end
        if resource.save
            # If the album is successfully saved, you can redirect or render as needed
            puts "album saved"
            set_my_flash_message("Album was successfully created.","success" )
            redirect_to session[:success_redirect] || root_path
        else
            puts "album not saved"
            set_my_flash_message("Album was not created.","error" )
            # If the album wasn't saved due to validation errors or other issues, render the 'new' template again
            render :new
        end
    end
    
    def new
        @resource = Album.new
        @resource.photos.build
    end
    def edit
    end
    def update
        if @resource.update(album_params)
            set_my_flash_message("Album was successfully updated.","success" )
            redirect_to session[:success_redirect] || root_path
        else
            set_my_flash_message("Album was not updated.","error" )
            render :edit
        end
    end
    def destroy
        if @resource.destroy
            set_my_flash_message("Album was successfully destroyed.","success" )
            redirect_to session[:success_redirect] || root_path
        else
            set_my_flash_message("Album was not destroyed.","error" )
            render :edit
        end
    end
    private
    def before_action_handle1
        @list_reacted_albums = current_user.reacted_albums.pluck(:id)
        @list_followings = current_user.following.pluck(:id)
    end
    def get_resource
        @resource = Album.find(params[:id])
    end
    def get_user
        @user = User.find(params[:user_id])
    end
    def album_params
        params.require(:album).permit(:title,:user_id, :description, :isPrivate, :numOfPhotos, :numOfLikes, photos_attributes: [:id, :image,:user_id, :_destroy])
    end
   
end