class MediaCreatorsController < ApplicationController
  before_action :require_admin!

  def index
    @creators = MediaCreator.all.order(:name)
  end

  def show
    @creator = MediaCreator.find(params[:id])
  end
end
