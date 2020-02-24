# == Schema Information
#
# Table name: media_images
#
#  id                 :integer          not null, primary key
#  attachable_id      :integer          not null
#  attachable_type    :integer          not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime
#  updated_at         :datetime
#

require 'spec_helper'

describe MediaImage, type: :model do
  it { is_expected.to have_attached_file(:image) }
  it { is_expected.to validate_attachment_content_type(:image).allowing('image/*') }
  it { is_expected.to belong_to :attachable}

end
