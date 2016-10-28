class CreateBubbles < ActiveRecord::Migration
  def change
    create_table :bubbles do |t|
      t.string  :name,   null: false
      t.string  :artist, null: false
      t.string  :medium, null: false
      t.integer :radius
      t.text    :thoughts
      t.text    :spoiler_thoughts
      t.date    :finish_date
      t.timestamps
    end
    add_attachment :bubbles, :image
    add_index :bubbles, :name
    add_index :bubbles, :artist
    add_index :bubbles, :medium
  end
end
