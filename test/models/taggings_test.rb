# == Schema Information
#
# Table name: taggings
#
#  id            :integer          not null, primary key
#  day_id        :integer          not null
#  taggable_id   :integer          not null
#  taggable_type :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#

require 'test_helper'

class TaggingsTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
