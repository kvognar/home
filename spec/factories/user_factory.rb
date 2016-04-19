# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string(255)      not null
#  is_admin      :boolean          default(FALSE)
#  password_hash :string(255)
#  session_token :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

FactoryGirl.define do
  factory :user do
    sequence :name do |n|
      "Mr. Midas #{n}"
    end
    password 'good morning'
  end
end
