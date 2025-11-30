class AddRejectedToComments < ActiveRecord::Migration[4.2]
  def change
    add_column :comments, :rejected, :boolean, default: false
    add_index :comments, :rejected
  end
end
