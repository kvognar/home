class MediaConsumptionsController < ApplicationController
  before_action :require_admin!

  def update
    @consumption = MediaConsumption.find(params[:id])
    if %w[in_progress ongoing].include?(params[:state]) && !@consumption.started?
      @consumption.start_date = Time.now
    end
    @consumption.update!(state: params[:state])
    redirect_to @consumption.media_work
  end

  def year_in_review
    @year = params[:year]
    start = Date.parse("January 1 #{params[:year]}")
    range = start...(start + 1.year)

    @sessions = MediaSession.joins(:day).includes(:day, media_consumption: :media_work).where(days: { day_of: range} )
    @data = YearInReviewHelper.new(@sessions).data
  end
end
