class LegacizeTags < ActiveRecord::Migration[4.2]
  def change
    rename_table :tags, :legacy_tags
    rename_table :taggings, :legacy_taggings
  end
end
