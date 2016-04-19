require 'spec_helper'

describe Api::PhotosController do
  let(:user) { create(:user, is_admin: true) }
  after(:each) { Photo.destroy_all }
  describe '#create' do
    it 'saves a photo' do
      controller.sign_in!(user)
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec/support/fixtures/profile.jpg'), "image/jpeg")
      post(:create, file: file)

      expect(Photo.count).to eq 1
      expect(Photo.first.photo_file_name).to eq 'profile.jpg'
    end
    it 'handles bad file types' do
      controller.sign_in!(user)
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec/support/fixtures/fake_profile.txt'), "text/txt")
      post(:create, file: file)
      expect(Photo.count).to eq 0
      expect(response.status).to eq 400
      expect(response.body).to include 'Photo content type is invalid'
    end
    it 'does not save photos if not signed in' do
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec/support/fixtures/fake_profile.txt'), "text/txt")
      post(:create, file: file)
      expect(Photo.count).to eq 0
      expect(response).to redirect_to days_url
    end
  end
end
