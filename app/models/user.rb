# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string(255)      not null
#  is_admin      :boolean          default(FALSE)
#  password_hash :string(255)
#  session_token :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class User < ActiveRecord::Base

  validates_uniqueness_of :name
  validates_presence_of :name
  has_many :sessions

  scope :admin, -> { where(is_admin: true).first }

  def password=(password)
    @password=password
    self.password_hash = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_hash).is_password?(password)
  end

end
