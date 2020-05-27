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

require 'spec_helper'

describe User, type: :model do

  describe 'validations' do
    subject { create(:user) }
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end
  
  it "knows if it's an admin" do
    admin = create(:user, is_admin: true)
    non_admin = create(:user)
    expect(admin.is_admin?).to be true
    expect(non_admin.is_admin).to be false
  end

end
