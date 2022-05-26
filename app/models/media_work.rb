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

  scope :search_term, ->(term) { with_creators.where('title LIKE :a OR search_creators.name LIKE :a', { a: "%#{term}%" }) }
  scope :with_creators, -> {
    joins('LEFT OUTER JOIN media_creator_works AS work_joins ON work_joins.media_work_id = media_works.id')
      .joins('LEFT OUTER JOIN media_creators AS search_creators ON search_creators.id = work_joins.media_creator_id')
  }
  scope :by_medium, ->(medium) { where(medium: medium) }
  scope :by_state, ->(state) { joins(:media_consumptions).where(media_consumptions: { state: state }) }
  scope :with_badge_ids, ->(ids) { ids.inject(joins(:badges)) { |query, id| query.where(id: MediaWorkBadge.where(badge_id: id).select(:media_work_id)) } }

  def state
    media_consumptions.last.state
  end

  def not_started?
    %w[someday queued].include? state
  end
end
