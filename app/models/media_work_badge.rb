# == Schema Information
#
# Table name: media_work_badges
#
#  id            :integer          not null, primary key
#  created_at    :datetime
#  updated_at    :datetime
#  media_work_id :integer
#  badge_id      :integer
#

class MediaWorkBadge < ActiveRecord::Base
  belongs_to :badge
  belongs_to :media_work
  validates :badge, presence: true
  validates :media_work, presence: true
end
