class MediaSessionService

  def self.save(params:, day:)
    new(params: params, day: day).run
    #puts params[:media_consumption]
  end

  def initialize(params:, day:)
    @params = params
    @day = day
  end

  def run
    @params[:media_consumption].each do |media_consumption_id, params|
      next unless params[:continued]
      media = MediaConsumption.find(media_consumption_id)
      session = MediaSession.find_or_initialize_by(media_consumption: media, day_id: @day.id)
      session.assign_attributes(session_params(params))
      if session.save!
        if params[:finish]
          media.update(state: 'finished')
          media.update(finish_date: Time.now)
        end
      end
    end
  end

  private

  def session_params(params)
    params.permit(:title, :text, :spoiler_text)
  end

end
