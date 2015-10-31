class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :day_id, null: false
      t.string :author
      t.string :author_email
      t.text :body, null: false
      t.datetime :date
      t.integer :parent_id
      t.timestamps
    end
    add_index :comments, :day_id
    add_index :comments, :parent_id
  end
end
