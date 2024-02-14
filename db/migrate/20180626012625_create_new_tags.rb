class CreateNewTags < ActiveRecord::Migration[4.2]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.integer :parent_id, null: true, index: true
      t.integer :lft, null: false, index: true
      t.integer :rgt, null: false, index: true
      t.integer :depth, null: false, index: true, default: 0
      t.integer :children_count, null: false, default: 0
      t.timestamps
    end
  end
end
