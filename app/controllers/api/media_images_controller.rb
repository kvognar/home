class Api::MediaImagesController < ApplicationController
  before_action :require_admin!

  def create
    @media_image = MediaImage.new(media_image_params.merge(image: params[:file]))
    if @media_image.save
      render json: { id: @media_image.id, url: @media_image.image.url(:medium) }, status: :ok
    else
      render json: { errors: @media_image.errors.full_messages }, status: :bad_request
    end
  end

  private

  def media_image_params
    params.require(:media_image).permit(:attackable_id, :attachable_type)
  end
end
