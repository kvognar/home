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
    @media_work, success = MediaWorkCreationService.create(params)

    respond_to do |format|
      if success
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
    @media_work, success = MediaWorkCreationService.update(@media_work, params)
    respond_to do |format|
      if success
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

end
