# == Schema Information
#
# Table name: days
#
#  id           :integer          not null, primary key
#  title        :string(255)      not null
#  number       :integer          not null
#  publish_date :datetime         not null
#  body         :text             not null
#  slug         :string(255)      not null
#  mouseover    :text
#  lyrics       :string(255)
#  lyric_credit :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'test_helper'

class DayTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
