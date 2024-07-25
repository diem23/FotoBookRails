class ReactAlbumsController < ApplicationController
    before_action :authenticate_user!
    def create
      react=ReactAlbum.new(user_id: current_user.id, album_id: params[:album2_id])
      react.save
    end
    def destroy
      react=ReactAlbum.find_by(user_id: current_user.id, album_id: params[:album2_id]).destroy
    end
    def react_button
      render partial: "shared/react_button", locals: {ele: Album.find(params[:album2_id]), inside_photo: false}
    end
    def unreact_button
      render partial: "shared/unreact_button", locals: {ele: Album.find(params[:album2_id]), inside_photo: false}
    end
end