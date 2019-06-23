# == Schema Information
#
# Table name: tags
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  parent_id      :integer
#  lft            :integer          not null
#  rgt            :integer          not null
#  depth          :integer          default(0), not null
#  children_count :integer          default(0), not null
#  created_at     :datetime
#  updated_at     :datetime
#  featured       :boolean          default(FALSE)
#

FactoryBot.define do
  factory :tag do
    sequence :name do |n|
      "the dragon of doubt #{n}"
    end
  end
end
