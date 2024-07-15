require 'debouncer/debounceable'
class Users::AlbumsController < ApplicationController
  extend Debouncer::Debounceable
  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def create
    p "inside create albummmmmm"
    p album_params
    # Rails.logger.debug "Album Params: #{album_params.inspect}"
    @album =  current_user.albums.new(album_params)
    puts @album.title
    puts @album.description
    puts @album.isPrivate
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
      redirect_to "/", notice: 'Album was successfully created.'
    else
      puts "album not saved"
      # If the album wasn't saved due to validation errors or other issues, render the 'new' template again
      render :new

  end
  end

  def new
    @album = Album.new
    @album.photos.build
  end

  def destroy
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
  debounce :update_num_of_likes, 10
  #STRONG PARAMS
  private
  def album_params
      params.require(:album).permit(:title,:user_id, :description, :isPrivate, :numOfPhotos, :numOfLikes, photos_attributes: [ :image,:user_id, :_destroy])
  end

end
