require 'debouncer/debounceable'
class DiscoverController < ApplicationController
    extend Debouncer::Debounceable
    def photo
        @list_photos =  Photo.public_photos.includes(:user)
    end

    def album
      @list_following = current_user.following
      @list_albums = @list_following.joins(:albums).select('users.*,albums.*').where(albums: {isPrivate: false}).order('albums.created_at DESC')
    end
    def follow
        if list_following.include?(params[:user_id].to_i)
            puts "unfollow"
            Follow.find_by(follower_id: current_user.id, followed_id: params[:user_id]).destroy
        else
            puts "follow"
            current_user.active_relate.create(followed_id: params[:user_id])
        end
    end

    debounce :follow, 3
  end
  