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
    common_tag_day_ids = (params[:tags].presence || []).map do |tag|
      Tag.find_by(name: tag).self_and_descendants.map(&:day_ids).flatten.uniq
    end.inject(:&).flatten

    common_media_day_ids = (params[:media_works].presence || []).map do |media_work_id|
      MediaConsumption.where(media_work_id: media_work_id).map { |i| i.media_sessions.pluck(:day_id) }
    end.inject(:&).flatten

    ids = if common_media_day_ids.present? && common_tag_day_ids.present?
      common_media_day_ids & common_tag_day_ids
    elsif common_media_day_ids.present?
      common_media_day_ids
    else
      common_tag_day_ids
    end

    @days  = Day.published.where(id: ids).pluck(:number)
    @total = Day.published.count
    render json: {
        days:  @days,
        total: @total
    }
  end

  def show
    @day = Day.find_by_number(params[:id])
    render json: {
        html: render_to_string(partial: 'days/show', locals: { day: @day, link_title: true, show_comments: false, show_nav_links: false })
    }
  end

  private

  def save_day
    Day.transaction do
      if @day.save
        add_and_remove_tags
        MediaSessionService.save(params: params, day: @day)
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
