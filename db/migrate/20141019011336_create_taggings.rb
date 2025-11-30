class CreateTaggings < ActiveRecord::Migration[4.2]
  def change
    create_table :taggings do |t|
      t.integer :day_id, null: false
      t.integer :taggable_id, null: false
      t.string :taggable_type, null: false

      t.timestamps
    end
    add_index :taggings, :day_id
    add_index :taggings, :taggable_id
    add_index :taggings, :taggable_type
  end
end
