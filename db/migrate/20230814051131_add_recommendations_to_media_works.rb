class AddRecommendationsToMediaWorks < ActiveRecord::Migration
  def change
    add_column :media_works, :recommended_by, :string
    add_column :media_works, :recommended_because, :text
  end
end
