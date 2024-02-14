class CreatePeople < ActiveRecord::Migration[4.2]
  def change
    create_table :people do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :people, :name, unique: true
  end
end
