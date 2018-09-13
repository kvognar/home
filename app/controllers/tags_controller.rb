class TagsController < ApplicationController

  def show
    if params[:legacy].present?
      @tag = LegacyTag.find(params[:id])
      @days = @tag.days.includes(:photo_of_the_day).paginate(page: params[:page])
    else
      @tag = Tag.find_by(name: params[:id])
      @days = Day.joins(:taggings).where(taggings: { tag:  @tag.self_and_descendants}).distinct.paginate(page: params[:page])
    end
  end

  def people
    @people = LegacyTag.people.includes(:photos).group_by { |tag| tag.name.first }
  end

  def categories
    @categories = LegacyTag.categories.includes(:photos).sort_by { |tag| tag.name }
  end
end
