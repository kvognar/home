# == Schema Information
#
# Table name: media_works
#
#  id         :integer          not null, primary key
#  medium     :string(255)      not null
#  title      :string(255)      not null
#  perennial  :boolean
#  created_at :datetime
#  updated_at :datetime
#

class MediaWork < ActiveRecord::Base
  has_many :media_consumptions
  has_many :media_creator_works
  has_many :media_creators, through: :media_creator_works
  has_one :media_image, as: :attachable
  has_many :media_work_badges
  has_many :badges, through: :media_work_badges

  validates :medium, presence: true
  validates :title, presence: true

  MEDIUM_OPTIONS = %w[book movie tv_show video_game podcast comic article youtuber stage_play other]

  def state
    media_consumptions.last.state
  end

  def not_started?
    %w[someday queued].include? state
  end
end
