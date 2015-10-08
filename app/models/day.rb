# == Schema Information
#
# Table name: days
#
#  id                 :integer          not null, primary key
#  title              :string(255)      not null
#  number             :integer          not null
#  publish_date       :datetime         not null
#  body               :text             not null
#  slug               :string(255)      not null
#  mouseover          :text
#  lyrics             :string(255)
#  lyric_credit       :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  whisper            :string(255)
#

class Day < ActiveRecord::Base
  extend FriendlyId
  validates :title, :number, :publish_date, :body, :whisper, presence: true
  validates :number,:whisper, uniqueness: true
  after_initialize :ensure_publish_date
  friendly_id :whisper, use: [:slugged, :finders]

  has_attached_file :photo,
                    styles: { thumb: '100x100#', medium: '1200x900>' },
                    convert_options: {
                      thumb: '-strip'
                    }
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  default_scope { order(publish_date: :desc) }

  
  private
  
  def ensure_publish_date
    self.publish_date ||= Time.now
  end
end
