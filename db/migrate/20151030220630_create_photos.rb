class CreatePhotos < ActiveRecord::Migration[4.2]
  def change
    create_table :photos do |t|
      t.integer :day_id
      t.boolean :is_canonical
      t.timestamps
    end
    add_attachment :photos, :photo
    add_index :photos, :day_id
    add_index :photos, :is_canonical
  end
end
