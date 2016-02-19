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

class Comment < ActiveRecord::Base
  belongs_to :day
  belongs_to :parent, class_name: 'Comment', foreign_key: :parent_id
  has_many :children, class_name: 'Comment', foreign_key: :parent_id

  scope :top_level, -> { where(parent_id: 0) }
  scope :approved,  -> { where(approved: true) }

  validates_presence_of :day, :body
end
