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
    subject { User.new(name: 'Mr. Midas', password: 'do not forget what you have done') }
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

end
