class TagsController < ApplicationController

  def show
    @tag = Tag.find(params[:id])
    @days = @tag.days.includes(:photo_of_the_day).paginate(page: params[:page])
  end

  def people
    @people = Tag.people.includes(:photos).group_by { |tag| tag.name.first }
  end
end
