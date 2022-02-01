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
    @day = Day.includes(:photo_of_the_day, :comments, media_sessions: { media_consumption: :media_work }).friendly.find(params[:id])
  end

  def index
    @days = Day.published.recent.paginate(page: params[:page]).includes(:tags, :photo_of_the_day, :approved_comments, media_sessions: { media_consumption: :media_work })
  end

  def calendar
    @days = Day.published.includes(:photo_of_the_day) #.paginate(page: params[:page])
  end

  def susurrus
    @days = Day.published.recent.select(:id, :slug)
  end

  def on_this_day
    dates        = []
    current_date = @date = params[:date].try(:to_date) || Date.today
    first_day    = Day.published.first.day_of
    while current_date >= first_day do
      dates << current_date
      current_date -= 1.year
    end
    @days = Day.published.recent.where(day_of: dates)
  end

  def your_song
    @tags      = Tag.all.order(:name)
    @media_works = MediaWork.all.order(:title)
    @day_count = Day.count
  end

  def feed
    @days = Day.published.recent.limit(10)
    respond_to do |format|
      format.rss { render layout: false }
    end
  end

end
