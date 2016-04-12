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

  context 'helper methods' do
    describe '#has_photo?' do
      it 'returns true if the day has a photo of the day' do
        day_with_photo = create(:day, photo_of_the_day: create(:photo, is_canonical: true))
        day_without_photo = create(:day)
        expect(day_with_photo.has_photo?).to be true
        expect(day_without_photo.has_photo?).to be false
      end
    end
    describe '#has_comments?' do
      it 'returns true if the day has approved comments' do
        day = create(:day)
        expect(day.has_comments?).to be false
        day.comments << create(:comment, approved: false)
        expect(day.has_comments?).to be false
        day.comments.first.update(approved: true)
        expect(day.reload.has_comments?).to be true
      end
    end
    describe '#top_level_comments' do
      it 'returns comments with no parent commnent' do
        day = create(:day)
        comment = create(:comment, day: day)
        child_comment = create(:comment, parent: comment, day: day)
        expect(day.top_level_comments).to match_array([comment])
      end
    end
  end
end