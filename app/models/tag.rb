# == Schema Information
#
# Table name: tags
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  parent_id      :integer
#  lft            :integer          not null
#  rgt            :integer          not null
#  depth          :integer          default(0), not null
#  children_count :integer          default(0), not null
#  created_at     :datetime
#  updated_at     :datetime
#  featured       :boolean          default(FALSE)
#

class Tag < ActiveRecord::Base
  include Taggable
  extend FriendlyId

  friendly_id :name

  has_many :taggings
  has_many :days, through: :taggings
  has_many :photos, -> { order(created_at: :desc).limit(1) }, through: :days, source: :photo_of_the_day

  scope :featured, -> { where(featured: true) }

  def preview_photo
    photos.first
  end

end
