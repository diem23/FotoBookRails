class PersonalInfoController < ApplicationController
    def photo
      @target_user= User.find(params[:id])
      @viewing_current_user =  @target_user == current_user
      if @viewing_current_user
        @list_photos =  @target_user.photos.order('photos.created_at DESC')
      else
        @list_photos =  @target_user.photos.public_photos.order('photos.created_at DESC')
      end
      
      @list_following = current_user.following.pluck(:id)
    end

    def album
      @target_user= User.find(params[:id])
      puts params[:id]
      puts @target_user
      @viewing_current_user =  @target_user == current_user
      if @viewing_current_user
        @list_albums =  @target_user.albums.order('albums.created_at DESC')
      else
        @list_albums =  @target_user.albums.public_albums.order('albums.created_at DESC')
      end
      #binding.pry
      @list_following = current_user.following.pluck(:id)
    end
    def following
      @target_user= User.find(params[:id])
      @viewing_current_user =  @target_user == current_user
      @list_following = current_user.following.pluck(:id)
      @list_following_target = @target_user.following
    end
    def follower
      @target_user= User.find(params[:id])
      @viewing_current_user =  @target_user == current_user
      @list_following = current_user.following.pluck(:id)
      @list_follower_target = @target_user.follower
    end

  end
  