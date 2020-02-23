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

  VALID_STATES = %w[someday queued in_progress icebox abandoned finished]

  belongs_to :media_work
  has_many :media_sessions

end
