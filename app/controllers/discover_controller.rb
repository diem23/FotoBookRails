require 'debouncer/debounceable'
class DiscoverController < ApplicationController
    extend Debouncer::Debounceable
    def photo
        @list_following = current_user.following.pluck(:id)
        puts @list_following, "list_followingggggggggggggggggggggg"
        @list_reacted_photos = current_user.reacted_photos.pluck(:id)
        puts @list_reacted_photos
        @list_photos =  Photo.public_photos.includes(:user)
        
    end

    def album
      @list_following = current_user.following.pluck(:id)
      puts @list_following, "list_followingggggggggggggggggggggg"
      @list_reacted_albums = current_user.reacted_albums.pluck(:id)
      @list_albums = Album.public_albums.includes(:user)
    end

    def follow
        @list_following = current_user.following.pluck(:id)
        if @list_following.include?(params[:user_id].to_i)
            puts "unfollow"
            Follow.find_by(follower_id: current_user.id, followed_id: params[:user_id]).destroy
        else
            puts "follow"
            current_user.active_relate.create(followed_id: params[:user_id])
        end
    end 
    debounce :follow, 10
  end
  