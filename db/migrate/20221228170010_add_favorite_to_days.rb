class AddFavoriteToDays < ActiveRecord::Migration[4.2]
  def change
    add_column :days, :favorite, :boolean, default: false, null: false, index: true
  end
end
