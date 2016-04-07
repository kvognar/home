FactoryGirl.define do
  factory :photo do
    photo { File.new("#{Rails.root}/spec/support/fixtures/profile.jpg") }
  end
end
