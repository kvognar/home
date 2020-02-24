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

require 'spec_helper'

describe MediaConsumption, type: :model do

  it { is_expected.to belong_to :media_work }
  it { is_expected.to have_many :media_sessions }
  it { is_expected.to validate_inclusion_of(:state).in_array(MediaConsumption::VALID_STATES) }

end
