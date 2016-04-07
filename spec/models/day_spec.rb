require 'spec_helper'

describe Day do
  describe 'validations' do
    subject { create(:day) }
    it { should validate_presence_of :title }
    it { should validate_presence_of :number }
    it { should validate_uniqueness_of :number }
    it { should validate_presence_of :body }
    it { should validate_presence_of :whisper }
    it { should validate_uniqueness_of :whisper }
  end
  describe 'associations' do
    it { should have_many :taggings }
    it { should have_many :tags }
    it { should have_many :people }
    it { should have_many :categories }
    it { should have_many :photos }
    it { should have_one :photo_of_the_day }
    it { should have_many :comments }
  end

  context 'callbacks' do
    describe '#ensure_publish_date' do
      it 'defaults to now' do
        expect(create(:day).publish_date).to be_present
      end
    end

    describe '#assign_day_of' do
      it 'uses the current day if the time is after 6am' do
        day = create(:day, publish_date: Date.today + 7.hours)
        expect(day.day_of).to eq Date.today
      end
      it 'uses the previous day if the time is before 6am' do
        day = create(:day, publish_date: Date.today + 5.hours)
        expect(day.day_of).to eq Date.yesterday
      end
    end
  end
end
