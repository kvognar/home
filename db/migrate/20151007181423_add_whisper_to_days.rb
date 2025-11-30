class AddWhisperToDays < ActiveRecord::Migration[4.2]
  def change
    add_column :days, :whisper, :string
    add_index :days, :whisper, unique: true
  end
end
