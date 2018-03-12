# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  tag_type   :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Tag, type: :model do
  it { should have_many(:taggings).dependent(:destroy) }
  it { should have_many :days }
end
