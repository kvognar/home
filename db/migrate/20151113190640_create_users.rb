class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.boolean :is_admin, default: false
      t.string :password_hash
      t.string :session_token
      t.timestamps
    end
    add_index :users, :name, unique: true
    add_index :users, :session_token, unique: true
  end
end
