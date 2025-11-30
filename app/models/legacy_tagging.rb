# == Schema Information
#
# Table name: legacy_taggings
#
#  id         :integer          not null, primary key
#  day_id     :integer          not null
#  tag_id     :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class LegacyTagging < ApplicationRecord
  belongs_to :legacy_tag, foreign_key: :tag_id
  belongs_to :day
end
