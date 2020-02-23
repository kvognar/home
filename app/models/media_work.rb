# == Schema Information
#
# Table name: media_works
#
#  id         :integer          not null, primary key
#  medium     :string(255)      not null
#  title      :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class MediaWork < ActiveRecord::Base

end
