class CreateLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :links do |t|
			t.string :name
			t.string :url
			t.text :description
			t.string :category
      t.timestamps
		end

		add_index :links, :category
  end
end
str
