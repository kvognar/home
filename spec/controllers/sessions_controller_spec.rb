require 'spec_helper'

describe SessionsController do
  let!(:user) { create(:user, is_admin: true, password: 'good morning') }
  it 'renders a new page' do
    get(:new)
    expect(response).to render_template(:new)
  end
  it 'signs in a user' do
    post(:create, secret: 'good morning')
    expect(controller.current_user).to eq user
    expect(response).to redirect_to days_url
  end
  it 'does not sign in a user with the incorrect password' do
    post(:create, secret: 'good night')
    expect(controller.current_user).to be_nil
    expect(flash[:error]).to eq 'Who are you?'
    expect(response).to redirect_to days_url
  end
  it 'signs out a user' do
    post(:create, secret: 'good morning')
    expect(controller.current_user).to eq user
    put(:destroy)
    expect(controller.current_user).to be_nil
  end
end
