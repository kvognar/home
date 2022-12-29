# == Schema Information
#
# Table name: days
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  number             :integer          not null
#  publish_date       :datetime
#  body               :text(65535)
#  slug               :string(255)
#  mouseover          :text(65535)
#  lyrics             :string(255)
#  lyric_credit       :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  whisper            :string(255)
#  day_of             :date
#  is_draft           :boolean          default(FALSE), not null
#  favorite           :boolean          default(FALSE), not null
#

FactoryGirl.define do
  factory :day do
    title "Photo"
    body "A long and meandering description of the mote of dust that hovered in front of my eyes this morning."
    mouseover "Extra thought about how the dust might have once been an eyelash or a fly wing or a bit of banana peel."
    lyrics "lost in the clouds"
    lyric_credit "The Transfiguration - Sufjan Stevens"
    sequence :whisper do |n|
      "secret inside jokes #{n}"
    end
    day_of Date.today
    sequence :number do |n|
      n
    end
  end
end
