class Api::PhotosController < ApplicationController
  before_action :require_admin!
  def create
    @photo = Photo.new(photo_params.merge(photo: params[:file]))
    if @photo.save
      render json: { id: @photo.id, url: @photo.photo.url(:medium) }, status: :ok
      puts "Photo saved!"
    else
      render json: { errors: @photo.errors.full_messages }, status: :bad_request
    end
  end

  def photo_params
    params.require(:photo).permit(:day_id, :is_canonical)
  end
end
