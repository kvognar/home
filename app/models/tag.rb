# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  type       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base
end
