class CreateMediaTags < ActiveRecord::Migration
  def change
    create_table :media_tags do |t|
      t.string :name, index: true, unique: true
      t.integer :lft, index: true
      t.integer :rgt, index: true
      t.integer :parent_id, index: true
      t.integer :depth, index: true
      t.timestamps
    end

    create_table :media_taggings do |t|
      t.timestamps
      t.references :media_work, index: true
      t.references :media_tag, index: true
    end
  end
end
