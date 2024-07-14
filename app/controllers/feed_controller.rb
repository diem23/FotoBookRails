class FeedController < ApplicationController
    def photo
      if user_signed_in?
        @list_reacted_photos= current_user.reacted_photos.pluck(:id)
        @list_following = current_user.following
        @list_photos =  @list_following.joins(:photos).select('users.*,photos.*').where(photos: {isPrivate: false}).order('photos.created_at DESC')
        

      end
    end

    def album
      @list_reacted_albums = current_user.reacted_albums.pluck(:id)
      @list_following = current_user.following
      @list_albums = @list_following.joins(:albums).select('users.*,albums.*').where(albums: {isPrivate: false}).order('albums.created_at DESC')
 
      
    end
  end
  