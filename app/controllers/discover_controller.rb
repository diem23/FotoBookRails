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
            @follow = Follow.find_by(follower_id: current_user.id, followed_id: params[:user_id])
            @follow.destroy
        else
            puts "follow"
            @follow=current_user.active_relate.new(followed_id: params[:user_id])
            @follow.save
        end

    end 
    private
    def follow_params
        params.require(:follow).permit(:followed_id)
    end
    debounce :follow, 10
  end
  