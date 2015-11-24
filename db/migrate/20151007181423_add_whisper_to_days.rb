class AddWhisperToDays < ActiveRecord::Migration
  def change
    add_column :days, :whisper, :string
    add_index :days, :whisper, unique: true
  end
end
