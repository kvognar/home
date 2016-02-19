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

ActiveRecord::Schema.define(version: 20160206214943) do

  create_table "comments", force: true do |t|
    t.integer  "day_id",                      null: false
    t.string   "author"
    t.string   "author_email"
    t.text     "body",                        null: false
    t.datetime "date"
    t.integer  "parent_id",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved",     default: true
  end

  add_index "comments", ["approved"], name: "index_comments_on_approved", using: :btree
  add_index "comments", ["day_id"], name: "index_comments_on_day_id", using: :btree
  add_index "comments", ["parent_id"], name: "index_comments_on_parent_id", using: :btree

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
    t.string   "whisper"
    t.date     "day_of"
  end

  add_index "days", ["day_of"], name: "index_days_on_day_of", using: :btree
  add_index "days", ["number"], name: "index_days_on_number", unique: true, using: :btree
  add_index "days", ["slug"], name: "index_days_on_slug", unique: true, using: :btree
  add_index "days", ["title"], name: "index_days_on_title", using: :btree
  add_index "days", ["whisper"], name: "index_days_on_whisper", unique: true, using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "people", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["name"], name: "index_people_on_name", unique: true, using: :btree

  create_table "photos", force: true do |t|
    t.integer  "day_id"
    t.boolean  "is_canonical"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "photos", ["day_id"], name: "index_photos_on_day_id", using: :btree
  add_index "photos", ["is_canonical"], name: "index_photos_on_is_canonical", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "day_id",     null: false
    t.integer  "tag_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["day_id"], name: "index_taggings_on_day_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name",       null: false
    t.string   "tag_type",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name", "tag_type"], name: "index_tags_on_name_and_tag_type", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "name",                          null: false
    t.boolean  "is_admin",      default: false
    t.string   "password_hash"
    t.string   "session_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree

end
