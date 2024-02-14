# == Schema Information
#
# Table name: media_creator_works
#
#  id               :integer          not null, primary key
#  media_creator_id :integer
#  media_work_id    :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class MediaCreatorWork < ApplicationRecord
  belongs_to :media_creator
  belongs_to :media_work
end
