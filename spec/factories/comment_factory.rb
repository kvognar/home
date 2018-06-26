# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  day_id       :integer          not null
#  author       :string(255)
#  author_email :string(255)
#  body         :text(65535)      not null
#  date         :datetime
#  parent_id    :integer          default(0)
#  created_at   :datetime
#  updated_at   :datetime
#  approved     :boolean          default(TRUE)
#  rejected     :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :comment do
    day
    author 'Umbrella Man'
    author_email 'good.morning@umbrellaman.com'
    body 'Good morning.'
  end
end
