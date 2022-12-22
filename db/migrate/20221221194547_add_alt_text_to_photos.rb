class AddAltTextToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :alt_text, :text
  end
end
