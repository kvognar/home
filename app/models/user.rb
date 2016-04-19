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

  validates_uniqueness_of :name, :session_token
  validates_presence_of :name, :session_token

  after_initialize :ensure_session_token

  scope :admin, -> { where(is_admin: true).first }

  def password=(password)
    @password=password
    self.password_hash = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_hash).is_password?(password)
  end

  def reset_session_token!
    self.session_token = generate_token
    self.save!
    self.session_token
  end

  def is_admin?
    self.is_admin
  end

  private

  def ensure_session_token
    self.session_token ||= generate_token
  end

  def generate_token
    SecureRandom::urlsafe_base64(16)
  end


end
