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
  end

  def new
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
end
