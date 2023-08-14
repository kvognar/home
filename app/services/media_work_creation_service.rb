class MediaWorkCreationService

  def self.create(params)
    new(params: params, media_work: MediaWork.new).run
  end

  def self.update(media_work, params)
    new(media_work: media_work, params: params).run
  end

  def initialize(media_work:, params:)
    @params = params
    @media_work = media_work
  end

  def run
    @media_work.assign_attributes(media_work_params)
    success = @media_work.save
    if @media_work.save
      add_and_remove_creators
      add_and_remove_tags
      add_image
      add_media_consumption
    end

    [@media_work, success]
  end

  private


  def add_image
    file = @params[:media_work][:image]
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

  def add_and_remove_tags
    TagService.new(tag_params, @media_work, MediaTag).add_and_remove_tags
  end

  def add_creators(creators)
    new_creators = creators - @media_work.media_creators
    new_creators.each { |creator| @media_work.media_creators << creator }
  end

  def add_media_consumption
    if @media_work.media_consumptions.empty?
      @media_work.media_consumptions.create(
          state: 'someday'
      )
    end
  end

  def remove_creators(creators_to_keep)
    creators_to_delete = @media_work.media_creators - creators_to_keep
    @media_work.media_creators.delete(creators_to_delete)
  end

  def creator_params
    @params.require(:media_work)[:media_creators].select(&:present?)
  end

  def media_work_params
    @params.require(:media_work).permit(:title, :perennial, :medium, :recommended_by, :recommended_because)
  end

  def tag_params
    @params.require(:media_work)[:media_tags].select(&:present?)
  end


end
