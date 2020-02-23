class CreateMediaLogTables < ActiveRecord::Migration
  def change
    create_table :media_creators do |t|
      t.string :name, null: false, index: true
      t.timestamps
    end

    create_table :media_works do |t|
      t.string :medium, null: false, index: true
      t.string :title, null: false, index: true
      t.timestamps
    end

    create_table :media_creator_works do |t|
      t.references :media_creator, index: true
      t.references :media_work, index: true
      t.timestamps
    end

    create_table :media_consumptions do |t|
      t.references :media_work
      t.datetime :start_date, index: true
      t.datetime :finish_date, index: true
      t.boolean :revisiting
      t.string :state, null: false, index: true
      t.timestamps
    end

    create_table :media_sessions do |t|
      t.references :day, index: true
      t.references :media_consumption, index: true, null: false
      t.string :title
      t.text :text
      t.text :spoiler_text
      t.timestamps
    end

    create_table :media_image do |t|
      t.integer :attachable_id, null: false
      t.integer :attachable_type, null: false
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.timestamps
    end
  end
end
