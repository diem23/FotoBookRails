
class Users::PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :just_allow_admin , only: [:index]
  def index
    @pagy,@list_photos = pagy(Photo.all)
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
      flash[:notice] = 'Photo was successfully updated.'
      redirect_to "/"
    else 
      flash[:notice] = 'Photo was not updated.'
      
      render :edit
    end
    
  end

  def create
    puts params
    @new_photo = Photo.new(title: params[:title], description: params[:description], isPrivate: params[:isPrivate]=="1", user_id: current_user.id, image: params[:image])
    if @new_photo.save
      redirect_to "/", notice: 'Photo was successfully created.'
    else
      render :new, notice: 'Photo was not created.'
    end
  end

  def new
    @photo = Photo.new
  end

  def destroy
    @photo = Photo.find(params[:id])
    @user_id = @photo.user_id
    if @photo.destroy
      redirect_to personal_info_photo_path(@user_id), notice: 'Photo was successfully deleted.'
    else
      render :edit, notice: 'Photo was not deleted.'
    end
  end


  def show
  end
  private
  def photo_params
    
    params.require(:photo).permit(:title, :description, :isPrivate, :image)
  end


end
