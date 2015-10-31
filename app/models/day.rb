# == Schema Information
#
# Table name: days
#
#  id                 :integer          not null, primary key
#  title              :string(255)      not null
#  number             :integer          not null
#  publish_date       :datetime         not null
#  body               :text             not null
#  slug               :string(255)      not null
#  mouseover          :text
#  lyrics             :string(255)
#  lyric_credit       :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  whisper            :string(255)
#

class Day < ActiveRecord::Base
  extend FriendlyId
  validates :title, :number, :publish_date, :body, :whisper, presence: true
  validates :number,:whisper, uniqueness: true
  after_initialize :ensure_publish_date
  friendly_id :whisper, use: [:slugged, :finders]

  has_many :taggings
  has_many :tags, through: :taggings, source: :tag

  has_many :people, -> { where tag_type: 'people' }, class_name: 'Tag', through: :taggings, source: :tag
  has_many :categories, -> { where tag_type: 'category' }, class_name: 'Tag', through: :taggings, source: :tag

  has_many :photos, dependent: :destroy
  has_one :photo_of_the_day, -> { where is_canonical: true }, class_name: 'Photo'

  default_scope { order(number: :desc) }

  def comments=(comments)

  end

  delegate :photo, to: :photo_of_the_day

  def has_photo?
    photo_of_the_day.present?
  end

  private
  
  def ensure_publish_date
    self.publish_date ||= Time.now
  end
end
