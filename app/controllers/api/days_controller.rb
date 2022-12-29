class Api::DaysController < ApplicationController
	include DayConcerns

	before_action :require_admin!, only: [:create, :update, :toggle_favorite]

	def create
		@day = Day.new(day_params)
		save_day
	end

	def update
		@day = Day.find(params[:id])
		@day.assign_attributes(day_params)
		save_day
	end

	def toggle_favorite
		@day = Day.find(params[:day_id])
		if @day.update(favorite: !@day.favorite)
			render json: { favorited: @day.favorite }
		else
			render json: {error: @day.errors.full_messages.to_sentence}, status: :unprocessable_entity
		end

	end

	def your_song
		common_tag_day_ids = (params[:tags].presence || []).map do |tag|
			Tag.find_by(name: tag).self_and_descendants.map(&:day_ids).flatten.uniq
		end.inject(:&)&.flatten

		common_media_day_ids = (params[:media_works].presence || []).map do |media_work_id|
			MediaConsumption.where(media_work_id: media_work_id).map { |i| i.media_sessions.pluck(:day_id) }
		end.inject(:&)&.flatten

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
				TagService.new(tag_params, @day, Tag).add_and_remove_tags
				MediaSessionService.save(params: params, day: @day)
				if params[:photo]
					photo = @day.photo_of_the_day
					photo&.update_attributes(alt_text: params[:photo][:alt_text])
				end
				render json: { url: day_url(@day), id: @day.id }, status: :ok
			else
				render json: { errors: @day.errors.full_messages }, status: :unprocessable_entity
			end
		end
	end

end
