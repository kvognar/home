module DayConcerns
  extend ActiveSupport::Concern

  private

  def add_and_remove_tags
    new_tag_names = tag_params.select { |name| name.include?('::') }
    debugger
    new_tags = new_tag_names.map { |name| Tag.recursive_create(name) }
    add_tags(tag_params - new_tag_names)
    remove_tags(tag_params - new_tag_names)
    add_tags(new_tags.select(&:persisted?).map(&:name))
  end

  def add_tags(names)
    new_tags = Tag.where(name: names) - @day.tags
    new_tags.each { |tag| @day.tags << tag }
  end

  def remove_tags(names)
    tags_to_keep = Tag.where(name: names)
    tags_to_delete = @day.tags - tags_to_keep
    @day.tags.delete(tags_to_delete)
  end

  def add_and_remove_legacy_tags
    ['people', 'categories'].each do |tag_type|
      add_legacy_tags(tag_type)
      remove_legacy_tags(tag_type)
    end
  end

  def add_legacy_tags(tag_type)
    if tag_params(tag_type).present?
      tag_params(tag_type).each do |tag_name|
        tag = LegacyTag.find_or_create_by(tag_type: tag_type, name: tag_name)
        @day.legacy_legacy_tags << tag unless @day.legacy_legacy_tags.include? tag
      end
    end
  end

  def remove_legacy_tags(tag_type)
    legacy_tags_to_keep = LegacyTag.where(tag_type: tag_type, name: tag_params(tag_type))
    legacy_tags_to_delete = @day.send(tag_type) - legacy_tags_to_keep
    @day.legacy_legacy_tags.delete(legacy_tags_to_delete)
  end

  def tag_params
    params.require(:day)[:tags].select(&:present?)
  end


  def legacy_tag_params(tag_type)
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
                                :lyric_credit,
                                :is_draft
    )
  end

end
