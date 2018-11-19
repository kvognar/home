class TagsController < ApplicationController

  def show
    if params[:legacy].present?
      @tag = LegacyTag.find(params[:id])
      @days = @tag.days.includes(:photo_of_the_day).paginate(page: params[:page])
    else
      @tag = Tag.find_by(name: params[:id])
      return not_found if @tag.nil?
      @days = Day.published.recent.joins(:taggings).where(taggings: { tag:  @tag.self_and_descendants}).distinct.paginate(page: params[:page])
    end
  end

  def people
    people_tag = Tag.find_by_name('people')
    @people = people_tag.descendants.includes(:photos).sort_by(&:name)
  end

  def index
    @tags_and_photos = []

    tags = Tag.featured.order(name: :asc)
    tags.each do |tag|
      tag_ids = tag.self_and_descendants.pluck(:id)
      day_ids = Day.joins(:taggings).where(taggings: { tag_id: tag_ids })
      photo = Photo.where(day_id: day_ids, is_canonical: true).last
      @tags_and_photos << [tag, photo]
    end
    render 'featured'
  end

  def categories
    @categories = LegacyTag.categories.includes(:photos).sort_by { |tag| tag.name }
  end
end
