# == Schema Information
#
# Table name: days
#
#  id                 :integer          not null, primary key
#  title              :string(255)      not null
#  number             :integer          not null
#  publish_date       :datetime         not null
#  body               :text             not null
#  slug               :string(255)      not null
#  mouseover          :text
#  lyrics             :string(255)
#  lyric_credit       :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  whisper            :string(255)
#

require 'test_helper'

class DayTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
