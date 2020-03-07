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

require 'spec_helper'

describe MediaWork, type: :model do
  it { is_expected.to have_many(:media_consumptions) }
  it { is_expected.to have_many(:media_creator_works) }
  it { is_expected.to have_many(:media_creators).through(:media_creator_works) }

  it { is_expected.to validate_presence_of(:medium) }
  it { is_expected.to validate_presence_of(:title) }
end
