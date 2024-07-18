
class Users::PhotosController < ApplicationController

  def index
  end


  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    puts "inside update photo"
    puts params
    puts photo_params
    if @photo.update(photo_params)
      redirect_to "/", notice: 'Photo was successfully created.'
    else 
      render :edit
    end
    
  end

  def create
    puts params
    @new_photo = Photo.new(title: params[:title], description: params[:description], isPrivate: params[:isPrivate]=="1", user_id: current_user.id, image: params[:image])
    @new_photo.save!
  end

  def new
    @photo = Photo.new
  end

  def destroy
    
    @photo = Photo.find(params[:id])
    @user_id = @photo.user_id
    @photo.destroy
    redirect_to personal_info_photo_path(@user_id), notice: 'Photo was successfully deleted.'
  end


  def show
  end
  private
  def photo_params
    params.require(:photo).permit(:title, :description, :isPrivate, :image)
  end


end
