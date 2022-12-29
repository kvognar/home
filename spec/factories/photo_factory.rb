# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  day_id             :integer
#  is_canonical       :boolean
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  alt_text           :text(65535)
#

FactoryGirl.define do
  factory :photo do
    photo { File.new("#{Rails.root}/spec/support/fixtures/profile.jpg") }
  end
end
