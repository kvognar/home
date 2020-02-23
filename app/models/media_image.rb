# == Schema Information
#
# Table name: media_images
#
#  id                 :integer          not null, primary key
#  attachable_id      :integer
#  attachable_type    :string
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class MediaImage < ActiveRecord::Base

  belongs_to :attachable, polymorphic: true

  has_attached_file :image,
                    styles: { thumb: '100x100#', medium: '1200x900>' },
                    convert_options: {
                        thumb: '-strip'
                    }

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

end
