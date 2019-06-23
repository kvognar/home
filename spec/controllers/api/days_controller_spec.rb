require 'spec_helper'

describe Api::DaysController, type: :controller do
  let!(:user) { create(:user, is_admin: true) }
  let(:photo) { create(:photo) }
  after(:each) { Photo.destroy_all }
  let(:day_attributes) do
    {
        title:        'test',
        number:       1618,
        body:         'It has been a good day.',
        mouseover:    'Secret message for you',
        lyrics:       'all things go',
        lyric_credit: 'Chicago - Sufjan Stevens',
        whisper:      'extra bonus secret'
    }
  end
  describe '#create' do
    it 'saves a new day' do
      controller.sign_in!(user)
      post(:create, params: {
          photo: { id: photo.id },
          day:   day_attributes.merge(
              tags:     ['umbrella man', 'the dragon of doubt', 'the effervescent sea', 'dreams']
          )
      })
      day = Day.first
      day_attributes.each do |attr_name, value|
        expect(day[attr_name]).to eq value
      end
      expect(day.photo_of_the_day).to eq photo
      expect(photo.reload.is_canonical).to eq true
      expect(day.slug).to eq 'extra-bonus-secret'
      expect(day.tags.map(&:name)).to match_array ['umbrella man', 'the dragon of doubt', 'the effervescent sea', 'dreams']
    end

    it 'returns errors if the day is invalid' do
      controller.sign_in!(user)
      post(:create, params: {
          day: {
              title:   'error',
              number:  1,
              whisper: 'this will break'
          }
      }
      )
      expect(response.body).to include("Body can't be blank")
      expect(Day.count).to eq 0
    end

    it 'redirects if not signed in' do
      post(:create, params:
          {

              photo: { id: photo.id },
              day:   day_attributes.merge(
                  people:     'umbrella man, the dragon of doubt',
                  categories: 'the effervescent sea, dreams'
              )
          }
      )
      expect(response).to redirect_to days_url
    end
  end

  describe '#update' do
    let(:day) { create(:day) }
    it 'updates the day' do
      controller.sign_in!(user)
      put(:update, params: { id: day.id, day: day_attributes })
      day.reload
      day_attributes.each do |attr_name, value|
        expect(day[attr_name]).to eq value
      end
      expect(day.slug).to eq 'extra-bonus-secret'
    end
    it 'redirects if not signed in' do
      put(:update, params: { id: day.id, day: day_attributes })
      expect(response).to redirect_to days_url
    end
    it 'returns errors if the day is invalid' do
      controller.sign_in!(user)
      put(:update, params: { id: day.id, day: { body: '' } })
      expect(response.body).to include("Body can't be blank")
      expect(day.reload.body).not_to be_blank
    end
  end

end
