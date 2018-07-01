class CreateNewTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :day_id, null: false, index: true
      t.integer :tag_id, null: false, index: true
      t.timestamps
    end
  end
end
