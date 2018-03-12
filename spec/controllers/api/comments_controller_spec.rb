require 'spec_helper'

describe Api::CommentsController, type: :controller do
  describe '#create' do
    let(:day) { create(:day) }
    let(:user) { create(:user) }
    let(:comment_fields) do
      {
          day_id: day.id,
          parent_id: 0,
          author: 'kozuch',
          author_email: 'the_requisite_scientist@subcon.com',
          body: 'hmm yes very interesting',
          day_number: day.number
      }
    end
    it 'creates an unapproved comment if not signed in' do
      post(:create, day_id: day.slug, comment: comment_fields)
      expect(response.status).to eq 200
      comment = Comment.first
      comment_fields.except(:day_number).each do |key, value|
        expect(comment[key]).to eq value
      end
      expect(comment.approved).to be false
    end
    it 'creates an approved comment if signed in' do
      controller.sign_in!(user)
      post(:create, day_id: day.slug, comment: comment_fields)
      expect(response.status).to eq 200
      comment = Comment.first
      comment_fields.except(:day_number).each do |key, value|
        expect(comment[key]).to eq value
      end
      expect(comment.approved).to be true
    end
    it 'returns errors if comment is not valid' do
      post(:create, day_id: day.slug, comment: {
          author: 'kozuch',
          body: '',
          day_number: day.number,
          day_id: day.id
      })
      expect(response.body).to include("Body can't be blank")
      expect(Comment.count).to eq 0
    end
  end
end
