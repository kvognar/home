class DaysController < ApplicationController
  include DayConcerns

  before_action :require_admin!, only: [:new, :create]
  
  def new
    @day = Day.new(number: Day.count + 1)
  end
  
  def create
    @day = Day.new(day_params)
    Day.transaction do
      if @day.save
        add_and_remove_tags
        # fail
        if params[:photo]
          photo = Photo.find(params[:photo][:id])
          photo.update_attributes(day_id: @day.id, is_canonical: true)
        end
        redirect_to @day
      else
        flash.now[:errors] = @day.errors.full_messages
        render :new
      end
    end
  end
  
  def show
    @day = Day.friendly.find(params[:id])
  end
  
  def index
    @days = Day.paginate(page: params[:page])
  end
  
end
