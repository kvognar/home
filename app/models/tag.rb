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
#

class Tag < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name
  acts_as_nested_set
  has_many :taggings
  has_many :days, through: :taggings

  validates :name, uniqueness: true

  before_validation :standardize_name

  def self.recursive_create(name_chain)
    names = name_chain.split('::')
    transaction do
      current_tag = Tag.find_or_create_by(name: names.first)
      names.drop(1).each do |name|
        current_tag = current_tag.children.find_or_create_by(name: name)
      end
      current_tag
    end
  end

  private

  def standardize_name
    self.name = self.name.downcase.strip
  end
end
