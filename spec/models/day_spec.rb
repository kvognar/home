# == Schema Information
#
# Table name: days
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  number             :integer          not null
#  publish_date       :datetime
#  body               :text(65535)
#  slug               :string(255)
#  mouseover          :text(65535)
#  lyrics             :string(255)
#  lyric_credit       :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  whisper            :string(255)
#  day_of             :date
#  is_draft           :boolean          default(FALSE), not null
#

require 'spec_helper'

describe Day, type: :model do
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
    it { should have_many :photos }
    it { should have_one :photo_of_the_day }
    it { should have_many :comments }
  end

  context 'drafts' do
    describe 'validations' do
      it 'should skip most validations as a draft' do
        draft = Day.create(number: 1, is_draft: true)
        expect(draft).to be_valid
        draft.is_draft = false
        expect(draft).to_not be_valid
      end
    end

    describe '#Day.draft' do
      it 'creates a new draft if none exists' do
        expect(Day.count).to eq 0
        draft = Day.draft
        expect(draft.is_draft?).to be true
        expect(Day.count).to eq 1
      end
      it 'fetches an existing draft if one exists' do
        draft = Day.create(number: 314, is_draft: true)
        expect(Day.draft).to eq draft
      end
    end
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

    describe 'friendly id' do
      it 'assigns the slug from a whisper' do
        day = create(:day, whisper: 'good morning love')
        expect(day.slug).to eq 'good-morning-love'
      end
    end
  end

  context 'helper methods' do
    describe '#has_photo?' do
      after { Photo.destroy_all }
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
