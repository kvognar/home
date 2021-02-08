class CreateBadgesAndMediaBadges < ActiveRecord::Migration
  def change

    create_table :badges do |t|
      t.timestamps
      t.string :name, index: true, unique: true
      t.string :symbol
      t.string :description
    end

    create_table :media_work_badges do |t|
      t.timestamps
      t.references :media_work, index: true
      t.references :badge, index: true
    end
  end

end
