module DayConcerns
  extend ActiveSupport::Concern

  private

  def add_and_remove_tags
    old_tags = Tag.where(name: tag_params)
    new_tag_names = tag_params.reject { |name| old_tags.map(&:name).include? name }
    new_tags = new_tag_names.map { |name| Tag.recursive_create(name) }
    add_tags(old_tags)
    remove_tags(old_tags)
    add_tags(new_tags.select(&:persisted?))
  end

  def add_tags(tags)
    new_tags = tags - @day.tags
    new_tags.each { |tag| @day.tags << tag }
  end

  def remove_tags(tags_to_keep)
    tags_to_delete = @day.tags - tags_to_keep
    @day.tags.delete(tags_to_delete)
  end

  def add_and_remove_legacy_tags
    ['people', 'categories'].each do |tag_type|
      add_legacy_tags(tag_type)
      remove_legacy_tags(tag_type)
    end
  end

  def tag_params
    tag_names = params[:day][:tags]
    if tag_names.present?
        tag_names.select(&:present?)
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
                                :lyric_credit,
                                :is_draft
    )
  end

end
