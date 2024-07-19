require 'debouncer/debounceable'
class Users::AlbumsController < ApplicationController
  extend Debouncer::Debounceable
  def index
  end

  def show
    puts "inside showwwwwwwwwwwwwwwwwwwwwwwww"
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    puts "inside update"
    puts album_params
    
    @album = Album.find(params[:id])
    @album.photos.each do |photo|
      puts "image link: ",photo.image
      puts "owner: ",photo.user_id
    end
    
    if @album.update(album_params)
      puts "album saved"
      redirect_to "/", notice: 'Album was successfully created.', type: 'success'
    else 
      puts "album not saved"
      render :edit, notice: 'Album was not created.', type: 'error'
    end
    puts @album.errors.details
    @album.valid?
    
  end

  def create
    p "inside create albummmmmm"
    p album_params
    @new_album_params = album_params.dup
    puts "new album params: ",@new_album_params
    @new_album_params[:photos_attributes].delete("0")
    
    # Rails.logger.debug "Album Params: #{album_params.inspect}"
    @album =  current_user.albums.new(@new_album_params)
    @album.photos.each do |photo|
      photo.user_id = @album.user_id
      photo.isPrivate = @album.isPrivate
      puts "image link: ",photo.image
      puts "owner: ",photo.user_id
    end
    @album.valid?
    puts @album.errors.details
    if @album.save
      # If the album is successfully saved, you can redirect or render as needed
      puts "album saved"
      redirect_to "/", notice: 'Album was successfully created.', type: 'success'
    else
      puts "album not saved"
      # If the album wasn't saved due to validation errors or other issues, render the 'new' template again
      render :new, notice: 'Album was not created.', type: 'error'

  end
  end

  def new
    @album = Album.new
    @album.photos.build
  end

  def destroy
    @album = Album.find(params[:id])
    if @album.destroy
      redirect_to root_path, notice: 'Album was successfully destroyed.'
    else  
      render :edit, notice: 'Album was not destroyed.'
    end
  end

  def update_num_of_likes
    if params[:gain]=="1"
      @album = Album.find(params[:id])
      @album.num_of_likes += 1
      @album.save
    else
      @album = Album.find(params[:id])
      @album.num_of_likes -= 1
      @album.save
    end
  end
  #STRONG PARAMS
  private
  def album_params
      params.require(:album).permit(:title,:user_id, :description, :isPrivate, :numOfPhotos, :numOfLikes, photos_attributes: [:id, :image,:user_id, :_destroy])
  end

end
