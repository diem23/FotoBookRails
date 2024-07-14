
class Users::PhotosController < ApplicationController

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def create
    puts params
    @new_photo = Photo.new(title: params[:title], description: params[:description], isPrivate: params[:isPrivate]==1, user_id: current_user.id, image: params[:image])
    @new_photo.save!
  end

  def new
  end

  def destroy
  end


end
