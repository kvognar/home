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
end
