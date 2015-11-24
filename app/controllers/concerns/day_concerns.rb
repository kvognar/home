module DayConcerns
  extend ActiveSupport::Concern

  private

  def add_and_remove_tags
    ['people', 'categories'].each do |tag_type|
      add_tags(tag_type)
      remove_tags(tag_type)
    end
  end

  def add_tags(tag_type)
    if tag_params(tag_type).present?
      tag_params(tag_type).each do |tag_name|
        tag = Tag.find_or_create_by(tag_type: tag_type, name: tag_name)
        @day.send(tag_type) << tag unless @day.send(tag_type).include? tag
      end
    end
  end

  def remove_tags(tag_type)
    tags_to_keep = Tag.where(tag_type: tag_type, name: tag_params(tag_type))
    tags_to_delete = @day.send(tag_type) - tags_to_keep
    @day.tags.delete(tags_to_delete)
  end


  def tag_params(tag_type)
    tag_string = params.require(:day)[tag_type]
    if tag_string.present?
      tag_string.split(',').map(&:strip)
    else
      []
    end
  end

  def day_params
    params.require(:day).permit(:title,
                                :number,
                                :photo,
                                :publish_date,
                                :body,
                                :whisper,
                                :mouseover,
                                :lyrics,
                                :lyric_credit)
  end

end
