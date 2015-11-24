# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string(255)      not null
#  is_admin      :boolean          default(FALSE)
#  password      :string(255)
#  session_token :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end
