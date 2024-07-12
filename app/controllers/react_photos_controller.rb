class ReactPhotosController < ApplicationController
    def create
        ReactPhoto.create(user_id: current_user.id, photo_id: params[:photo_id])
    end
    def destroy
        ReactPhoto.find_by(user_id: current_user.id, photo_id: params[:photo_id]).destroy
    end
    def handle_like
        @list_reacted_photos = current_user.reacted_photos.pluck(:id)
        if @list_reacted_photos.include?(params[:photo_id].to_i)
            ReactPhoto.find_by(user_id: current_user.id, photo_id: params[:photo_id]).destroy
        else
            ReactPhoto.create(user_id: current_user.id, photo_id: params[:photo_id])
        end
    end

end