# == Schema Information
#
# Table name: days
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  number             :integer          not null
#  publish_date       :datetime
#  body               :text
#  slug               :string(255)
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
#  day_of             :date
#  is_draft           :boolean          default(FALSE), not null
#

class Day < ActiveRecord::Base
  extend FriendlyId
  friendly_id :whisper, use: :slugged

  ##### Validations #####
  validates :title, :number, :publish_date, :body, :whisper, presence: true, unless: :is_draft?
  validates :number,:whisper, uniqueness: true

  ##### Callbacks #####

  before_validation :ensure_publish_date, unless: :is_draft?
  before_validation :assign_day_of,       unless: :is_draft?

  ##### Associations ######

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings, source: :tag

  has_many :people, -> { where tag_type: 'people' }, class_name: 'Tag', through: :taggings, source: :tag
  has_many :categories, -> { where tag_type: 'categories' }, class_name: 'Tag', through: :taggings, source: :tag

  has_many :photos, dependent: :destroy
  has_one :photo_of_the_day, -> { where is_canonical: true }, class_name: 'Photo'
  delegate :photo, to: :photo_of_the_day

  has_many :comments, dependent: :destroy

  ##### Defaults ######
  default_scope { order(number: :desc) }
  self.per_page = 10

  ##### Scopes #####

  scope :drafts, -> { where(is_draft: true) }
  scope :published, -> { where(is_draft: false) }

  ##### Class methods #####

  def Day.draft
    day = Day.find_or_initialize_by(is_draft: true)
    unless day.persisted?
      day.number = Day.count + 1
      day.save!
    end
    day
  end


  def has_photo?
    photo_of_the_day.present?
  end

  def has_comments?
    comments.approved.present?
  end

  def top_level_comments
    comments.select { |comment| comment.parent_id == 0 }
  end

  private
  
  def ensure_publish_date
    self.publish_date ||= Time.now unless is_draft?
  end

  def assign_day_of
    if publish_date.hour < 6
      self.day_of = publish_date.to_date - 1.day
    else
      self.day_of = publish_date.to_date
    end
  end
end
