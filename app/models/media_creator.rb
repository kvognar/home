# == Schema Information
#
# Table name: media_creators
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class MediaCreator < ActiveRecord::Base
  validates :name, presence: true
  has_many :media_images, as: :attachable
  has_many :media_creator_works
  has_many :media_works, through: :media_creator_works
end
