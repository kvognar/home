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
#

require 'spec_helper'

describe Photo do

  after(:each) { Photo.destroy_all }
  it { should have_attached_file(:photo) }
  it { should validate_attachment_content_type(:photo).allowing('image/*') }
  it { should belong_to :day }

  it 'should be valid' do
    photo = create(:photo)
    expect(photo.photo).to be_present
    expect(photo).to be_valid
  end
end
