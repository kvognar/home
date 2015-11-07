# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  tag_type   :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :days, through: :taggings, source: :day
end
