# == Schema Information
#
# Table name: media_works
#
#  id         :integer          not null, primary key
#  medium     :string(255)      not null
#  title      :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class MediaWork < ActiveRecord::Base
  has_many :media_consumptions
  has_many :media_creator_works
  has_many :media_creators, through: :media_creator_works

  validates :medium, presence: true
  validates :title, presence: true
end
