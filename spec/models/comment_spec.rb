# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  day_id       :integer          not null
#  author       :string(255)
#  author_email :string(255)
#  body         :text             not null
#  date         :datetime
#  parent_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Comment do
  pending "add some examples to (or delete) #{__FILE__}"
end
