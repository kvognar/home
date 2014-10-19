# == Schema Information
#
# Table name: days
#
#  id           :integer          not null, primary key
#  title        :string(255)      not null
#  number       :integer          not null
#  publish_date :datetime         not null
#  body         :text             not null
#  slug         :string(255)      not null
#  mouseover    :text
#  lyrics       :string(255)
#  lyric_credit :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Day < ActiveRecord::Base
  validates :title, :number, :publish_date, :body, :slug, presence: true
  validates :number, uniqueness: true
  after_initialize :ensure_publish_date
  before_save :slugify_slug
  
  has_attached_file :photo, 
                    styles: { thumb: '100x100#', medium: '1200x900>' },
                    convert_options: {
                      thumb: '-strip'
                    }
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  
  
  private
  
  def ensure_publish_date
    self.publish_date ||= Time.now
  end
  
  def slugify_slug
    self.slug = self.slug.parameterize
  end
end
