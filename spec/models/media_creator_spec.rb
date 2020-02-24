# == Schema Information
#
# Table name: media_creators
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

RSpec.describe MediaCreator, type: :model do

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_many :media_images }

end
