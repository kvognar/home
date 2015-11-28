class Api::MigrationsController < ApplicationController

  def migrate
    Day.transaction do

      @day = Day.new(day_params)
      if @day.save
        add_tags
        add_categories
        add_comments
        if params[:photo]
          @photo = Photo.new(photo: photo_params[:photo], day: @day, is_canonical: true)
          if @photo.save
            render json: "Day #{@day.number} uploaded!"
          else
            render json: "photo couldn't save :("
          end
        else
          render json: "Photo #{@day.number} uploaded!"
        end
      else
        render json: @day.errors.full_messages
      end

    end
  end

  def update_migrate
    @day = Day.find_by_number(params[:number])
    if @day.update_attributes(body: params[:body])
      render json: "Day #{@day.number} patched!"
    else
      render json: @day.errors.full_messages
    end
  end

  private

  def day_params
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

  def category_params
    params.require(:day).permit(categories: [])
  end

  def photo_params
    params.require(:photo).permit(:photo)
  end

  def comment_params
    params.require(:day).permit(comments: [:id, :author, :author_email, :body, :date, :parent_id])
  end

  def add_tags
    if tag_params.present?
      tag_params[:tags].each do |tag|
        @day.tags << Tag.find_or_create_by(name: tag, tag_type: 'people')
      end
    end
  end

  def add_categories
    if category_params.present?
      category_params[:categories].each do |category|
        @day.categories << Tag.find_or_create_by(name: category, tag_type: 'categories')
      end
    end
  end

  def add_comments
    if comment_params.present?
      comment_params[:comments].each_value do |comment|
        @day.comments.create(comment)
      end
    end
  end

end
