# == Schema Information
#
# Table name: links
#
# id               :integer    not null, primary key
# name             :string
# url              :string
# description      :text
# category         :string
# created_at       :datetime
# updated_at       :datetime
class Link < ApplicationRecord
	VALID_CATEGORIES = %w[friends cool_people cool_things references webgarden]

	validates :name, presence: true
	validates :url, presence: true, uniqueness: true
	validates :category, inclusion: { in: VALID_CATEGORIES }

end
