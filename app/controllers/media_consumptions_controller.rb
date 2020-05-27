class MediaConsumptionsController < ApplicationController
  before_action :require_admin!

  def update
    @consumption = MediaConsumption.find(params[:id])
    if params[:state] == 'in_progress' && !@consumption.started?
      @consumption.start_date = Time.now
    end
    @consumption.update!(state: params[:state])
    redirect_to @consumption.media_work
  end
end
