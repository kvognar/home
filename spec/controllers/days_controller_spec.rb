require 'spec_helper'

describe DaysController do
  let!(:day_1) { create(:day) }
  let!(:day_2) { create(:day) }
  let!(:user) { create(:user, is_admin: true) }

  describe '#new' do
    it 'renders the edit day page with a new day draft' do
      controller.sign_in!(user)
      get(:new)
      expect(assigns(:day).number).to eq 3
      expect(assigns(:day).is_draft).to eq true
      expect(response).to render_template :edit
    end
    it 'redirects to index if not signed in' do
      get(:new)
      expect(response).to redirect_to days_url
    end
  end

  describe '#edit' do
    it 'renders the edit page' do
      controller.sign_in!(user)
      get(:edit, id: day_1.slug)
      expect(assigns(:day)).to eq day_1
      expect(response).to render_template :edit
    end
    it 'redirects to index if not signed in' do
      get(:edit, id: day_1.slug)
      expect(response).to redirect_to days_url
    end
  end

  describe '#show' do
    it 'renders the show page' do
      get(:show, id: day_1.slug)
      expect(assigns(:day)).to eq day_1
      expect(response).to render_template :show
    end
  end

  describe '#index' do
    it 'renders the index' do
      get(:index)
      expect(assigns(:days)).to eq [day_2, day_1]
      expect(response).to render_template :index
    end
    it 'paginates correctly' do
      ten_days = (1..10).map { create(:day) }
      get(:index)
      expect(assigns(:days)).to eq ten_days.reverse
      get(:index, page: 2)
      expect(assigns(:days)).to eq [day_2, day_1]
    end
  end

  describe '#calendar' do
    it 'renders all of the days???' do
      get(:calendar)
      expect(assigns(:days)).to match_array Day.all
      expect(response).to render_template :calendar
    end
  end

  describe '#feed' do
    it 'renders an rss feed' do
      get(:feed, format: :rss)
      expect(assigns(:days)).to eq [day_2, day_1]
      expect(response).to render_template :feed
    end
  end
end
