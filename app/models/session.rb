# == Schema Information
#
# Table name: sessions
#
#  id            :integer          not null, primary key
#  session_token :string(255)
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Session < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  validates :session_token, presence: true, uniqueness: true

  before_validation :ensure_session_token

  def reset_session_token!
    self.session_token = generate_token
    self.save!
    self.session_token
  end

  private

  def ensure_session_token
    self.session_token ||= generate_token
  end

  def generate_token
    SecureRandom::urlsafe_base64(16)
  end

end
