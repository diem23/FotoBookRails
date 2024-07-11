class PersonalInfoController < ApplicationController
    def photo
      @target_user= User.find(params[:id])
      puts params[:id]
      puts @target_user
      @list_photos =  @target_user.photos.where(isPrivate: false).order('photos.created_at DESC')
    end

    def album
      @target_user= User.find(params[:id])
      puts params[:id]
      puts @target_user
      @list_albums = @target_user.albums.where(isPrivate: false).order('albums.created_at DESC')
    end
    def following
      @target_user= User.find(params[:id])
    end
    def follower
      @target_user= User.find(params[:id])
    end

  end
  