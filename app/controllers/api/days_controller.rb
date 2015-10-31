class Api::DaysController < ApplicationController


  def migrate
    Day.transaction do

      @day = Day.new(migration_params)
      if @day.save
        puts "HEY LOOK AT THIS LOOK LOOK"
        if tag_params.present?
          tag_params[:tags].each do |tag|
            puts tag
            @day.tags << Tag.find_or_create_by(name: tag, tag_type: 'tag')
          end
        end
        @photo = Photo.new(photo: photo_params[:photo], day: @day, is_canonical: true)
        if @photo.save
          render json: "hurrah!"
        else
          render json: "photo couldn't save :("
        end
      else
        render json: @day.errors.full_messages
      end

    end
  end

  private


  def migration_params
    params.require(:day).permit(:title,
                                :number,
                                :photo,
                                :publish_date,
                                :body,
                                :whisper,
                                :mouseover,
                                :lyrics,
                                :lyric_credit,
    )
  end

  def tag_params
    params.require(:day).permit(tags: [])
  end

  def photo_params
    params.require(:photo).permit(:photo)
  end
end
