FactoryGirl.define do
  factory :user do
    sequence :name do |n|
      "Mr. Midas #{n}"
    end
    password 'good morning'
  end
end
