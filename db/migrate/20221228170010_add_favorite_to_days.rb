class AddFavoriteToDays < ActiveRecord::Migration
  def change
    add_column :days, :favorite, :boolean, default: false, null: false, index: true
  end
end
