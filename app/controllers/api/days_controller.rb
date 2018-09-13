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
    common_day_ids = params[:tags].map do |tag|
      Tag.find_by(name: tag).self_and_descendants.map(&:day_ids).flatten.uniq
    end.inject(:&)

    @days = Day.where(id: common_day_ids).pluck(:number)
    @total = Day.published.count
    render json: {
        days: @days,
        total: @total
    }
  end

  def show
    @day = Day.find_by_number(params[:id])
    p @day
    render json: {
        html: render_to_string(partial: 'days/show', locals: {day: @day, link_title: true, show_comments: false})
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
