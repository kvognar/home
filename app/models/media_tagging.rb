# == Schema Information
#
# Table name: media_taggings
#
#  id            :integer          not null, primary key
#  created_at    :datetime
#  updated_at    :datetime
#  media_work_id :integer
#  media_tag_id  :integer
#

class MediaTagging < ActiveRecord::Base
  belongs_to :media_work
  belongs_to :media_tag
end
