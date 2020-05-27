# == Schema Information
#
# Table name: media_sessions
#
#  id                   :integer          not null, primary key
#  day_id               :integer
#  media_consumption_id :integer          not null
#  title                :string(255)
#  text                 :text(65535)
#  spoiler_text         :text(65535)
#  created_at           :datetime
#  updated_at           :datetime
#

class MediaSession < ActiveRecord::Base

  has_many :media_images, as: :attachable
  belongs_to :day
  belongs_to :media_consumption, dependent: :destroy
  has_one :media_work, through: :media_consumption
  validates :media_consumption, presence: true

  def has_spoilers?
    spoiler_text.present?
  end
  
end
