# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141019033525) do

  create_table "days", force: true do |t|
    t.string   "title",              null: false
    t.integer  "number",             null: false
    t.datetime "publish_date",       null: false
    t.text     "body",               null: false
    t.string   "slug",               null: false
    t.text     "mouseover"
    t.string   "lyrics"
    t.string   "lyric_credit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "days", ["number"], name: "index_days_on_number", unique: true, using: :btree
  add_index "days", ["slug"], name: "index_days_on_slug", unique: true, using: :btree
  add_index "days", ["title"], name: "index_days_on_title", using: :btree

  create_table "people", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["name"], name: "index_people_on_name", unique: true, using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "day_id",        null: false
    t.integer  "taggable_id",   null: false
    t.string   "taggable_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["day_id"], name: "index_taggings_on_day_id", using: :btree
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree

end
