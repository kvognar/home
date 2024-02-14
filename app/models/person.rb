# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Person < ApplicationRecord
end
