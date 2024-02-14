# == Schema Information
#
# Table name: badges
#
#  id          :integer          not null, primary key
#  created_at  :datetime
#  updated_at  :datetime
#  name        :string(255)
#  symbol      :string(255)
#  description :string(255)
#

class Badge < ApplicationRecord
  has_many :media_work_badges
  has_many :media_works, through: :media_work_badges
end
