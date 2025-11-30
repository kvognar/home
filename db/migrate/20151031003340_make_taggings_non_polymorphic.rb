class MakeTaggingsNonPolymorphic < ActiveRecord::Migration[4.2]
  def change
    remove_column :taggings, :taggable_type
    rename_column :taggings, :taggable_id, :tag_id
  end
end
