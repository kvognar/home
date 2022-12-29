# == Schema Information
#
# Table name: media_tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  lft        :integer
#  rgt        :integer
#  parent_id  :integer
#  depth      :integer
#  created_at :datetime
#  updated_at :datetime
#

class MediaTag < ActiveRecord::Base
  extend FriendlyId
  include Taggable

  has_many :media_taggings
  has_many :media_works, through: :media_taggings
  friendly_id :name

  validates :name, uniqueness: true
end
