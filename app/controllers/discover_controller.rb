
class DiscoverController < ApplicationController
    Pagy::DEFAULT[:limit] = 10
    before_action :authenticate_user!, only: :follow
    before_action :just_allow_user
    def photo
        @pagy,@list_photos =  pagy(Photo.public_photos.includes(:user), items: 10)
        if user_signed_in?
            @list_following = current_user.following.pluck(:id) 
            @list_reacted_photos = current_user.reacted_photos.pluck(:id) 
        else 
            @list_following = []
            @list_reacted_photos = []
        end
        
    end

    def album
        @pagy,@list_albums = pagy(Album.public_albums.includes(:photos).where(isPrivate: false).includes(:user), items: 10)
        if user_signed_in?
            @list_following = current_user.following.pluck(:id)
            puts @list_following, "list_followingggggggggggggggggggggg"
            @list_reacted_albums = current_user.reacted_albums.pluck(:id)
        else
            @list_following = []
            @list_reacted_albums = []
        end
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

  end
  