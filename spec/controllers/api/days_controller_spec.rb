require 'spec_helper'

describe Api::DaysController do
    let!(:user) { create(:user, is_admin: true) }
    let(:photo) { create(:photo) }
    let(:day_attributes) do
      {
        title: 'test',
        number: 1618,
        body: 'It has been a good day.',
        mouseover: 'Secret message for you',
        lyrics:  'all things go',
        lyric_credit: 'Chicago - Sufjan Stevens',
        whisper: 'extra bonus secret'
      }
    end
  describe '#create' do
    it 'saves a new day' do
      controller.sign_in!(user)
      post(:create,
           photo: { id: photo.id },
           day: day_attributes.merge(
            people: 'umbrella man, the dragon of doubt',
            categories: 'the effervescent sea, dreams'
           )
      )
      day = Day.find(day_attributes[:whisper].parameterize)
      day_attributes.each do |attr_name, value|
        expect(day[attr_name]).to eq value
      end
      expect(day.photo_of_the_day).to eq photo
      expect(photo.reload.is_canonical).to eq true
      expect(day.people.map(&:name)).to match_array ['umbrella man', 'the dragon of doubt']
      expect(day.categories.map(&:name)).to match_array ['the effervescent sea', 'dreams']
    end

    it 'redirects if not signed in' do
      post(:create,
           photo: { id: photo.id },
           day: day_attributes.merge(
               people: 'umbrella man, the dragon of doubt',
               categories: 'the effervescent sea, dreams'
           )
      )
      expect(response).to redirect_to days_url
    end
  end

  describe '#update' do
    let(:day) { create(:day) }
    it 'updates the day' do
      controller.sign_in!(user)
      put(:update, id: day.slug, day: day_attributes)
      day.reload
      day_attributes.each do |attr_name, value|
        expect(day[attr_name]).to eq value
      end
    end
    it 'redirects if not signed in' do
      put(:update, id: day.slug, day: day_attributes)
      expect(response).to redirect_to days_url
    end
  end

end
