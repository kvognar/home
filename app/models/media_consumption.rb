# == Schema Information
#
# Table name: media_consumptions
#
#  id            :integer          not null, primary key
#  media_work_id :integer
#  start_date    :datetime
#  finish_date   :datetime
#  revisiting    :boolean
#  state         :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#

class MediaConsumption < ActiveRecord::Base

  VALID_STATES = %w[in_progress queued someday ongoing icebox finished abandoned]

  belongs_to :media_work
  validates :media_work, presence: true
  has_many :media_sessions

  validates :state, inclusion: { in: VALID_STATES }

  delegate :title, to: :media_work

  def start_state
    if media_work.perennial?
      'ongoing'
    else
      'in_progress'
    end
  end

  def started?
    start_date.present?
  end

  def finished?
    finish_date.present?
  end

  def in_progress?
    state == 'in_progress'
  end

  def perennial?
    state == 'perennial'
  end

  def queued?
    state == 'queued'
  end

  def abandoned?
    state == 'abandoned'
  end

  def icebox?
    state == 'icebox'
  end
end
