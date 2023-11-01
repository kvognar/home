class MediaConsumptionsController < ApplicationController
  before_action :require_admin!, only: [:update, :create]

  def create
    @media_work = MediaWork.find(params[:media_work_id])
    @consumption = @media_work.media_consumptions.create(
      start_date: Time.now,
      state: 'in_progress',
      revisiting: params[:revisiting]
    )
    redirect_to @media_work
  end

  def update
    @consumption = MediaConsumption.find(params[:id])
    if %w[in_progress ongoing].include?(params[:state]) && !@consumption.started?
      @consumption.start_date = Time.now
    end
    @consumption.update!(state: params[:state])
    redirect_to @consumption.media_work
  end

end
