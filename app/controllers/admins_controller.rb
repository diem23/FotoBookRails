class AdminsController < ApplicationController
    before_action :authenticate_user!
    before_action :just_allow_admin
    Pagy::DEFAULT[:limit] = 40
    def manage_users
        @pagy,@resources = pagy(User.all)
    end
    def manage_photos
        @pagy,@resources = pagy(Photo.all)
    end
    def manage_albums
        @pagy,@resources = pagy(Album.all)
    end
    def edit_user
        @resource = User.find(params[:id])
    end
end