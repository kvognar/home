class AddAltTextToPhotos < ActiveRecord::Migration[4.2]
  def change
    add_column :photos, :alt_text, :text
  end
end
