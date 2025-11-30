class Admin::QuickTagsController < ApplicationController
  before_action :require_admin!
  include DayConcerns
  def show
    @day = Day.friendly.find(params[:id])
  end

  def update
    @day = Day.find(params[:id])
    add_and_remove_tags
    redirect_back(fallout_location: day_path(@day))
  end
end
