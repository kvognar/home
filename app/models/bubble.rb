# == Schema Information
#
# Table name: bubbles
#
#  id                 :integer          not null, primary key
#  name               :string(255)      not null
#  artist             :string(255)      not null
#  medium             :string(255)      not null
#  radius             :integer
#  thoughts           :text
#  spoiler_thoughts   :text
#  finish_date        :date
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Bubble < ActiveRecord::Base
  validates_presence_of :name, :artist, :medium
end
