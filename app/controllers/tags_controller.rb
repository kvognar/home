class TagsController < ApplicationController

  def show
    @tag = Tag.find(params[:id])
    @days = @tag.days.includes(:photo_of_the_day).paginate(page: params[:page])
  end
end
