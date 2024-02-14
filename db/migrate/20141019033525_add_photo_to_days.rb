class AddPhotoToDays < ActiveRecord::Migration[4.2]
  def change
    add_attachment :days, :photo
  end
end
