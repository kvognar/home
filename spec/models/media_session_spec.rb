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

require 'spec_helper'

describe MediaCreatorWork, type: :model do
  subject { MediaCreatorWork.new }

  it { is_expected.to belong_to(:media_creator).dependent(:destroy) }
  it { is_expected.to belong_to(:media_work).dependent(:destroy) }

end
