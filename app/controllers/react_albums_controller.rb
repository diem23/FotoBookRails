class ReactAlbumsController < ApplicationController
    def create
      ReactAlbum.create(user_id: current_user.id, album_id: params[:album_id])
    end
    def destroy
      ReactAlbum.find_by(user_id: current_user.id, album_id: params[:album_id]).destroy
    end
    def handle_like
      @list_reacted_albums = current_user.reacted_albums.pluck(:id)
      if @list_reacted_albums.include?(params[:album_id].to_i)
        ReactAlbum.find_by(user_id: current_user.id, album_id: params[:album_id]).destroy
      else
        ReactAlbum.create(user_id: current_user.id, album_id: params[:album_id])
      end
  end
end