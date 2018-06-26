class TagsController < ApplicationController

  def show
    if params[:legacy].present?
      @tag = LegacyTag.find(params[:id])
    else
      @tag = Tag.find_by(name: params[:id])
    end
    @days = @tag.days.includes(:photo_of_the_day).paginate(page: params[:page])
  end

  def people
    @people = LegacyTag.people.includes(:photos).group_by { |tag| tag.name.first }
  end

  def categories
    @categories = LegacyTag.categories.includes(:photos).sort_by { |tag| tag.name }
  end
end
