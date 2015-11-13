class Api::DaysController < ApplicationController
  include DayConcerns

  def create
    @day = Day.new(day_params)
    Day.transaction do
      if @day.save
        add_and_remove_tags
        if params[:photo]
          photo = Photo.find(params[:photo][:id])
          photo.update_attributes(day_id: @day.id, is_canonical: true)
        end
        render json: { url: day_url(@day) }, status: :ok
      else
        render json: { errors: @day.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

end
