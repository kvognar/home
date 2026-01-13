class StaticPagesController < ApplicationController

	after_action :allow_iframe, only: :webgarden
  def home
    @day = Day.joins(:photo_of_the_day).includes(:photo_of_the_day).last
  end

  def contact
  end
  
  def resume
    send_file(
    "#{Rails.root}/public/resume.pdf",
    filename: "resume.pdf",
    type: "application/pdf"
    )
  end

  def ♥︎
    hide_navbar
    render 'rsvp'
	end

	def webgarden
		hide_navbar

		dates        = []
		current_date = @date = Date.yesterday
		first_day    = Day.published.first.day_of

		while current_date >= first_day do
			dates << current_date
			current_date -= 1.year
		end

		@days = Day.published.recent.includes(:tags, :photo_of_the_day, :approved_comments, media_sessions: { media_consumption: :media_work }).where(day_of: dates)

		# for testing
		# @days = (Day.joins(:photo_of_the_day).all.to_a * 6).first(16)

		render 'webgarden'
	end

	private

	def allow_iframe
		response.headers.except! 'X-Frame-Options'
	end
end
