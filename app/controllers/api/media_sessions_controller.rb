class Api::MediaSessionsController < ApplicationController

  before_action :require_admin!

  def perennial_form
    @media_consumption = MediaConsumption.find_or_initialize_by(media_work_id: params[:media_work_id])
    @media_consumption.update(state: 'in_progress') if @media_consumption.new_record?
    @media_session = @media_consumption.media_sessions.find_or_initialize_by(day_id: params[:day_id])
    render json: {
        html: render_to_string(partial: 'days/media_log', locals: { media: @media_consumption, session: @media_session })
    }
  end

end
