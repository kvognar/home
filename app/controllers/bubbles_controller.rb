class BubblesController < ApplicationController

  def index
    @bubbles = Bubble.all
  end

  def show
    @bubble = Bubble.find(params[:id])
  end

  def new
    @bubble = Bubble.new
  end

  def create
    @bubble = Bubble.new(bubble_params)
    if @bubble.save
      redirect_to @bubble
    else
      flash.now[:error] = "Could not save bubble!"
      flash.now[:errors] = @bubble.errors.full_messages
      render :new
    end
  end

  def edit

  end

  def bubble_params
    params.require(:bubble).permit(:name, :artist, :medium, :thoughts, :spoiler_thoughts, :finish_date)
  end
end
