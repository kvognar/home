# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string(255)      not null
#  is_admin      :boolean          default(FALSE)
#  password      :string(255)
#  session_token :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe User do

  describe 'validations' do
    subject { create(:user) }
    it { should validate_presence_of :name }
    it { should validate_presence_of :session_token }
    it { should validate_uniqueness_of :name }
    it { should validate_uniqueness_of :session_token }
  end


  it 'generates a session token and password hash on creation' do
    user = User.create!(name: 'Mr. Midas', password: 'do not forget what you have done')
    expect(user.session_token).to be_present
    expect(user.password_hash).to be_present
    expect(User.first.is_password?('do not forget what you have done')).to be true
  end

  it 'ensures a session token' do
    expect(User.new.session_token).to be_present
  end

  it "knows if it's an admin" do
    admin = create(:user, is_admin: true)
    non_admin = create(:user)
    expect(admin.is_admin?).to be true
    expect(non_admin.is_admin).to be false
  end

end
