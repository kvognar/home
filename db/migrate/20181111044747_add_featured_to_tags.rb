class AddFeaturedToTags < ActiveRecord::Migration
  def change
    add_column :tags, :featured, :boolean, default: false
    add_index :tags, :featured
  end
end
