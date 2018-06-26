# == Schema Information
#
# Table name: taggings
#
#  id         :integer          not null, primary key
#  day_id     :integer          not null
#  tag_id     :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :day
  validates :day_id, uniqueness: { scope: :tag_id }
end
