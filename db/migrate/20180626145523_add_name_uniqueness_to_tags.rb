class AddNameUniquenessToTags < ActiveRecord::Migration[4.2]
  def change
    add_index :tags, :name, unique: true
  end
end
