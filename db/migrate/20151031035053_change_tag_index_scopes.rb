class ChangeTagIndexScopes < ActiveRecord::Migration
  def change
    remove_index :tags, :name
    add_index :tags, [:name, :tag_type], unique: true
  end
end
