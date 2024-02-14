# == Schema Information
#
# Table name: legacy_tags
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  tag_type   :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class LegacyTag < ApplicationRecord
  has_many :legacy_taggings, foreign_key: :tag_id, dependent: :destroy
  has_many :days, through: :legacy_taggings, source: :day
  has_many :photos, -> { order(created_at: :desc).limit(1) }, through: :days, source: :photo_of_the_day

  scope :people, -> { where tag_type: 'people' }
  scope :categories, -> { where tag_type: 'categories' }

  default_scope { order(:name) }

  def preview_photo
    photos.first
  end
end
