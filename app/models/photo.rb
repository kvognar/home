# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  day_id             :integer
#  is_canonical       :boolean
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  alt_text           :text
#

class Photo < ActiveRecord::Base

  belongs_to :day

  has_attached_file :photo,
                    styles: { thumb: '100x100#', medium: '1200x900>' },
                    convert_options: {
                        thumb: '-strip'
                    }
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

end
