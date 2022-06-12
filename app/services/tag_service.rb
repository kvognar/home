class TagService
  def initialize(params, taggable, tag_type)
    @params = params
    @taggable = taggable
    @tag_type = tag_type
  end

  def add_and_remove_tags
    old_tags = @tag_type.where(name: @params)
    new_tag_names = @params.reject { |name| old_tags.map(&:name).include? name }
    new_tags = new_tag_names.map { |name| @tag_type.recursive_create(name) }
    add_tags(old_tags)
    remove_tags(old_tags)
    add_tags(new_tags.select(&:persisted?))
    # fail
  end

  def add_tags(tags)
    new_tags = tags - @taggable.tags
    new_tags.each { |tag| @taggable.tags << tag }
  end

  def remove_tags(tags_to_keep)
    tags_to_delete = @taggable.tags - tags_to_keep
    @taggable.tags.delete(tags_to_delete)
  end

end
