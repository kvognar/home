require 'spec_helper'

describe CommentsController, type: :controller do
  let(:unapproved_comment) { create(:comment, approved: false) }
  let(:approved_comment) { create(:comment, approved: true) }
  let(:user) { create(:user, is_admin: true) }

  describe '#index' do
    it 'lists the unapproved comments' do
      controller.sign_in!(user)
      get :index
      expect(assigns(:comments)).to match_array([unapproved_comment])
    end
    it 'redirects to days if not signed in' do
      get :index
      expect(response).to redirect_to days_url
    end
  end
  describe '#update' do
    it 'approves a comment' do
      controller.sign_in!(user)
      put(:update, id: unapproved_comment.id, comment: { approved: true })
      expect(unapproved_comment.reload.approved).to be true
      expect(response).to redirect_to comments_url
    end
    it 'redirects if not signed in' do
      put(:update, id: unapproved_comment.id, comment: { approved: true })
      expect(unapproved_comment.reload.approved).to be false
      expect(response).to redirect_to days_url
    end
  end
end
