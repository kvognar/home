class Api::DaysController < ApplicationController
  include DayConcerns

  before_action :require_admin!, only: [:create, :update]

  def create
    @day = Day.new(day_params)
    save_day
  end

  def update
    @day = Day.find(params[:id])
    @day.assign_attributes(day_params)
    save_day
  end

  def your_song
    person = Tag.people.first
    @days = person.days.pluck(:number)
    @total = Day.published.count
    render json: {
        days: @days,
        total: @total
    }
  end

  private

  def save_day
    Day.transaction do
      if @day.save
        add_and_remove_tags
        if params[:photo]
          photo = Photo.find(params[:photo][:id])
          photo.update_attributes(day_id: @day.id, is_canonical: true)
        end
        render json: { url: day_url(@day), id: @day.id }, status: :ok
      else
        render json: { errors: @day.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

end
