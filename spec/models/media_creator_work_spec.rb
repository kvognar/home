# == Schema Information
#
# Table name: media_creator_works
#
#  id               :integer          not null, primary key
#  media_creator_id :integer
#  media_work_id    :integer
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

describe MediaCreatorWork, type: :model do

  it { is_expected.to belong_to :media_creator }
  it { is_expected.to belong_to :media_work }
end
