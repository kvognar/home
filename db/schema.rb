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

ActiveRecord::Schema.define(version: 20181111044747) do

  create_table "bubbles", force: :cascade do |t|
    t.string   "name",               limit: 255,   null: false
    t.string   "artist",             limit: 255,   null: false
    t.string   "medium",             limit: 255,   null: false
    t.integer  "radius",             limit: 4
    t.text     "thoughts",           limit: 65535
    t.text     "spoiler_thoughts",   limit: 65535
    t.date     "finish_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  add_index "bubbles", ["artist"], name: "index_bubbles_on_artist", using: :btree
  add_index "bubbles", ["medium"], name: "index_bubbles_on_medium", using: :btree
  add_index "bubbles", ["name"], name: "index_bubbles_on_name", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "day_id",       limit: 4,                     null: false
    t.string   "author",       limit: 255
    t.string   "author_email", limit: 255
    t.text     "body",         limit: 65535,                 null: false
    t.datetime "date"
    t.integer  "parent_id",    limit: 4,     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved",                   default: true
    t.boolean  "rejected",                   default: false
  end

  add_index "comments", ["approved"], name: "index_comments_on_approved", using: :btree
  add_index "comments", ["day_id"], name: "index_comments_on_day_id", using: :btree
  add_index "comments", ["parent_id"], name: "index_comments_on_parent_id", using: :btree
  add_index "comments", ["rejected"], name: "index_comments_on_rejected", using: :btree

  create_table "days", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.integer  "number",             limit: 4,                     null: false
    t.datetime "publish_date"
    t.text     "body",               limit: 65535
    t.string   "slug",               limit: 255
    t.text     "mouseover",          limit: 65535
    t.string   "lyrics",             limit: 255
    t.string   "lyric_credit",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name",    limit: 255
    t.string   "photo_content_type", limit: 255
    t.integer  "photo_file_size",    limit: 4
    t.datetime "photo_updated_at"
    t.string   "whisper",            limit: 255
    t.date     "day_of"
    t.boolean  "is_draft",                         default: false, null: false
  end

  add_index "days", ["day_of"], name: "index_days_on_day_of", using: :btree
  add_index "days", ["is_draft"], name: "index_days_on_is_draft", using: :btree
  add_index "days", ["number"], name: "index_days_on_number", unique: true, using: :btree
  add_index "days", ["slug"], name: "index_days_on_slug", unique: true, using: :btree
  add_index "days", ["title"], name: "index_days_on_title", using: :btree
  add_index "days", ["whisper"], name: "index_days_on_whisper", unique: true, using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "legacy_taggings", force: :cascade do |t|
    t.integer  "day_id",     limit: 4, null: false
    t.integer  "tag_id",     limit: 4, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "legacy_taggings", ["day_id"], name: "index_legacy_taggings_on_day_id", using: :btree
  add_index "legacy_taggings", ["tag_id"], name: "index_legacy_taggings_on_tag_id", using: :btree

  create_table "legacy_tags", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.string   "tag_type",   limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "legacy_tags", ["name", "tag_type"], name: "index_legacy_tags_on_name_and_tag_type", unique: true, using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["name"], name: "index_people_on_name", unique: true, using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "day_id",             limit: 4
    t.boolean  "is_canonical"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name",    limit: 255
    t.string   "photo_content_type", limit: 255
    t.integer  "photo_file_size",    limit: 4
    t.datetime "photo_updated_at"
  end

  add_index "photos", ["day_id"], name: "index_photos_on_day_id", using: :btree
  add_index "photos", ["is_canonical"], name: "index_photos_on_is_canonical", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "day_id",     limit: 4, null: false
    t.integer  "tag_id",     limit: 4, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["day_id"], name: "index_taggings_on_day_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",           limit: 255,                 null: false
    t.integer  "parent_id",      limit: 4
    t.integer  "lft",            limit: 4,                   null: false
    t.integer  "rgt",            limit: 4,                   null: false
    t.integer  "depth",          limit: 4,   default: 0,     null: false
    t.integer  "children_count", limit: 4,   default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "featured",                   default: false
  end

  add_index "tags", ["depth"], name: "index_tags_on_depth", using: :btree
  add_index "tags", ["featured"], name: "index_tags_on_featured", using: :btree
  add_index "tags", ["lft"], name: "index_tags_on_lft", using: :btree
  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree
  add_index "tags", ["parent_id"], name: "index_tags_on_parent_id", using: :btree
  add_index "tags", ["rgt"], name: "index_tags_on_rgt", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",          limit: 255,                 null: false
    t.boolean  "is_admin",                  default: false
    t.string   "password_hash", limit: 255
    t.string   "session_token", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree

end
