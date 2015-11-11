class DaysController < ApplicationController
  
  def new
    @day = Day.new(number: Day.count + 1)
  end
  
  def create
    @day = Day.new(day_params)
    if @day.save
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
  
  def show
    @day = Day.friendly.find(params[:id])
  end
  
  def index
    @days = Day.paginate(page: params[:page])
  end
  
  private
  
  def day_params
    params.require(:day).permit(:title,
                                :number,
                                :photo,
                                :publish_date,
                                :body,
                                :whisper,
                                :mouseover,
                                :lyrics,
                                :lyric_credit)
  end
end
