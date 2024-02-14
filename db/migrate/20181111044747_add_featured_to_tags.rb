class AddFeaturedToTags < ActiveRecord::Migration[4.2]
  def change
    add_column :tags, :featured, :boolean, default: false
    add_index :tags, :featured
  end
end
