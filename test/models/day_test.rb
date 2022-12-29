# == Schema Information
#
# Table name: days
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  number             :integer          not null
#  publish_date       :datetime
#  body               :text(65535)
#  slug               :string(255)
#  mouseover          :text(65535)
#  lyrics             :string(255)
#  lyric_credit       :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  whisper            :string(255)
#  day_of             :date
#  is_draft           :boolean          default(FALSE), not null
#  favorite           :boolean          default(FALSE), not null
#

require 'test_helper'

class DayTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
