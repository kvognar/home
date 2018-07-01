class LegacizeTags < ActiveRecord::Migration
  def change
    rename_table :tags, :legacy_tags
    rename_table :taggings, :legacy_taggings
  end
end
