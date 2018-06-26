# == Schema Information
#
# Table name: tags
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  parent_id      :integer
#  lft            :integer          not null
#  rgt            :integer          not null
#  depth          :integer          not null
#  children_count :integer          default(0), not null
#  created_at     :datetime
#  updated_at     :datetime
#

class Tag < ActiveRecord::Base
  acts_as_nested_set
  has_many :taggings
  has_many :days, through: :taggings
end
