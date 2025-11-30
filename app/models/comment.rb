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

class Comment < ApplicationRecord
  belongs_to :day
  belongs_to :parent, class_name: 'Comment', foreign_key: :parent_id, optional: true
  has_many :children, class_name: 'Comment', foreign_key: :parent_id

  scope :top_level,  -> { where(parent_id: 0) }
  scope :approved,   -> { where(approved: true) }
  scope :unapproved, -> { where(approved: false, rejected: false) }
  scope :rejected,   -> { where(rejected: true) }

  validates_presence_of :day, :body, :author
end
