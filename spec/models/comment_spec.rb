# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  day_id       :integer          not null
#  author       :string(255)
#  author_email :string(255)
#  body         :text(65535)      not null
#  date         :datetime
#  parent_id    :integer          default(0)
#  created_at   :datetime
#  updated_at   :datetime
#  approved     :boolean          default(TRUE)
#  rejected     :boolean          default(FALSE)
#

require 'spec_helper'

describe Comment, type: :model do
  context 'validations' do
    it { should validate_presence_of :day }
    it { should validate_presence_of :body }
  end
  context 'associations' do
    it { should belong_to :day }
    it { should belong_to :parent }
    it { should have_many :children }
  end
  context 'scopes' do
    let!(:top_level_comment) { create(:comment, approved: true) }
    let!(:child_comment)     { create(:comment, parent: top_level_comment, approved: false) }
    describe '#top_level' do
      it 'returns comments with no parent comment' do
        expect(Comment.top_level).to match_array([top_level_comment])
      end
    end
    describe '#approved' do
      it 'returns only approved comments' do
        expect(Comment.approved).to match_array([top_level_comment])
      end
    end
    describe '#unapproved' do
      it 'returns only unapproved comments' do
        expect(Comment.unapproved).to match_array([child_comment])
      end
    end

  end
end
