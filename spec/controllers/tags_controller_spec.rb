require 'spec_helper'

describe TagsController do
  describe '#show' do
    it 'shows days with the given tag' do
      day_with_tag = create(:day)
      tag = create(:tag)
      day_with_tag.tags << tag
      day_without_tag = create(:day)

      get(:show, id: tag.id)
      expect(assigns(:days)).to include(day_with_tag)
      expect(assigns(:days)).not_to include(day_without_tag)
    end
  end
end
