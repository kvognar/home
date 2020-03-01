class MediaWorksController < ApplicationController
  before_action :set_media_work, only: [:show, :edit, :update, :destroy]
  before_action :require_admin!

  # GET /media_works
  # GET /media_works.json
  def index
    @media_works = MediaWork.all
  end

  # GET /media_works/1
  # GET /media_works/1.json
  def show
  end

  # GET /media_works/new
  def new
    @media_work = MediaWork.new
  end

  # GET /media_works/1/edit
  def edit
  end

  # POST /media_works
  # POST /media_works.json
  def create
    @media_work = MediaWork.new(media_work_params)

    respond_to do |format|
      if @media_work.save
        add_and_remove_creators
        add_image
        format.html { redirect_to @media_work, notice: 'Media work was successfully created.' }
        format.json { render :show, status: :created, location: @media_work }
      else
        format.html { render :new }
        format.json { render json: @media_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /media_works/1
  # PATCH/PUT /media_works/1.json
  def update
    respond_to do |format|
      if @media_work.update(media_work_params)
        add_and_remove_creators
        add_image
        format.html { redirect_to @media_work, notice: 'Media work was successfully updated.' }
        format.json { render :show, status: :ok, location: @media_work }
      else
        format.html { render :edit }
        format.json { render json: @media_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media_works/1
  # DELETE /media_works/1.json
  def destroy
    @media_work.destroy
    respond_to do |format|
      format.html { redirect_to media_works_url, notice: 'Media work was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_media_work
    @media_work = MediaWork.find(params[:id])
  end

  def media_work_params
    params.require(:media_work).permit(:title, :perennial, :medium)
  end

  def add_image
    file = params[:media_work][:image]
    if file.present?
      @image = MediaImage.new(image: file, attachable: @media_work)
      @image.save
    end
  end

  def add_and_remove_creators
    old_creators      = MediaCreator.where(name: creator_params)
    new_creator_names = creator_params.reject { |name| old_creators.map(&:name).include? name }
    new_creators      = new_creator_names.map { |name| MediaCreator.find_or_create_by(name: name) }
    add_creators(old_creators)
    remove_creators(old_creators)
    add_creators(new_creators.select(&:persisted?))
  end

  def add_creators(creators)
    new_creators = creators - @media_work.media_creators
    new_creators.each { |creator| @media_work.media_creators << creator }
  end

  def remove_creators(creators_to_keep)
    creators_to_delete = @media_work.media_creators - creators_to_keep
    @media_work.media_creators.delete(creators_to_delete)
  end

  def creator_params
    params.require(:media_work)[:media_creators].select(&:present?)
  end


end
