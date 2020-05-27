class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :session_token, index: true
      t.references :user, index: true
      t.timestamps
    end
  end
end
