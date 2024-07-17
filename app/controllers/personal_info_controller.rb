class PersonalInfoController < ApplicationController
    def photo
      @target_user= User.find(params[:id])
      
      @list_following = current_user.following.pluck(:id)
      @list_photos =  @target_user.photos.public_photos.order('photos.created_at DESC')
    end

    def album
      @target_user= User.find(params[:id])
      puts params[:id]
      puts @target_user
      @list_following = current_user.following.pluck(:id)
      @list_albums = @target_user.albums.public_albums.order('albums.created_at DESC')
    end
    def following
      @target_user= User.find(params[:id])
      @list_following = current_user.following.pluck(:id)
      @list_following_target = @target_user.following
    end
    def follower
      @target_user= User.find(params[:id])
      @list_following = current_user.following.pluck(:id)
      @list_follower_target = @target_user.follower
    end

  end
  