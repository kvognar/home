# == Schema Information
#
# Table name: taggings
#
#  id            :integer          not null, primary key
#  day_id        :integer          not null
#  taggable_id   :integer          not null
#  taggable_type :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Tagging < ActiveRecord::Base
end
