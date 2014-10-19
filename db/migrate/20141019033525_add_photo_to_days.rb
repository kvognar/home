class AddPhotoToDays < ActiveRecord::Migration
  def change
    add_attachment :days, :photo
  end
end
