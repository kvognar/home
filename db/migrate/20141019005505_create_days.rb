class CreateDays < ActiveRecord::Migration[4.2]
  def change
    create_table :days do |t|
      t.string :title, null: false
      t.integer :number, null: false
      t.datetime :publish_date, null: false
      t.text :body, null: false
      t.string :slug, null: false
      t.text :mouseover
      t.string :lyrics
      t.string :lyric_credit

      t.timestamps
    end
    add_index :days, :title
    add_index :days, :number, unique: true
    add_index :days, :slug, unique: true
  end
end
