class Admin::TagsController < ApplicationController

  before_action :require_admin!

  def index
    @tags = Tag.roots
  end

  def new
    @tags = Tag.all.order(:name)
    @tag  = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = "#{@tag.name} was saved!"
      redirect_to admin_tags_path
    else
      flash.now[:errors] = @tag.errors.full_messages
      render :new
    end
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      render json: @tag.to_json
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:parent_id, :name, :featured)
  end
end
