class Api::PhotosController < ApplicationController
  def create
    @photo = Photo.new(photo: params[:file])
    if @photo.save
      render json: { id: @photo.id, url: @photo.photo.url(:medium) }, status: :ok
      puts "Photo saved!"
    else
      render json: "oops", status: :bad_request
      puts @photo.errors.full_messages
    end
  end

  def photo_params
    params.require(:file)
  end
end
