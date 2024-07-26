class ReactPhotosController < ApplicationController
    before_action :authenticate_user!
    def create
        react = ReactPhoto.new(user_id: current_user.id, photo_id: params[:photo_id])
        react.save
    end
    def destroy
        react = ReactPhoto.find_by(user_id: current_user.id, photo_id: params[:photo_id]).destroy
    end
    def react_button
        render partial: "shared/react_button", locals: {ele: Photo.find(params[:photo_id]), inside_photo: true}
    end
    def unreact_button
        render partial: "shared/unreact_button", locals: {ele: Photo.find(params[:photo_id]), inside_photo: true}
    end
    

end