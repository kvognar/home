class DaysController < ApplicationController
  include DayConcerns

  before_action :require_admin!, only: [:new, :create, :edit]
  
  def new
    @day = Day.draft
    render :edit
  end

  def edit
    @day = Day.friendly.find(params[:id])
  end
  
  def show
    @day = Day.includes(:photo_of_the_day, :comments).friendly.find(params[:id])
  end

  def index
    @days = Day.published.paginate(page: params[:page]).includes(:tags, :photo_of_the_day, :approved_comments)
  end

  def calendar
    @days = Day.published.includes(:photo_of_the_day)#.paginate(page: params[:page])
  end

  def susurrus
    @days = Day.published.select(:id, :slug)
  end

  def feed
    @days = Day.limit(10)
    respond_to do |format|
      format.rss { render layout: false }
    end
  end
  
end
