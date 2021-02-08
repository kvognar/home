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

ActiveRecord::Schema.define(version: 20210207221632) do

  create_table "badges", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",        limit: 255
    t.string   "symbol",      limit: 255
    t.string   "description", limit: 255
  end

  add_index "badges", ["name"], name: "index_badges_on_name", using: :btree

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

  create_table "media_consumptions", force: :cascade do |t|
    t.integer  "media_work_id", limit: 4
    t.datetime "start_date"
    t.datetime "finish_date"
    t.boolean  "revisiting"
    t.string   "state",         limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "media_consumptions", ["finish_date"], name: "index_media_consumptions_on_finish_date", using: :btree
  add_index "media_consumptions", ["start_date"], name: "index_media_consumptions_on_start_date", using: :btree
  add_index "media_consumptions", ["state"], name: "index_media_consumptions_on_state", using: :btree

  create_table "media_creator_works", force: :cascade do |t|
    t.integer  "media_creator_id", limit: 4
    t.integer  "media_work_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "media_creator_works", ["media_creator_id"], name: "index_media_creator_works_on_media_creator_id", using: :btree
  add_index "media_creator_works", ["media_work_id"], name: "index_media_creator_works_on_media_work_id", using: :btree

  create_table "media_creators", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "media_creators", ["name"], name: "index_media_creators_on_name", using: :btree

  create_table "media_images", force: :cascade do |t|
    t.integer  "attachable_id",      limit: 4,   null: false
    t.integer  "attachable_type",    limit: 4,   null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "media_sessions", force: :cascade do |t|
    t.integer  "day_id",               limit: 4
    t.integer  "media_consumption_id", limit: 4,     null: false
    t.string   "title",                limit: 255
    t.text     "text",                 limit: 65535
    t.text     "spoiler_text",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "media_sessions", ["day_id"], name: "index_media_sessions_on_day_id", using: :btree
  add_index "media_sessions", ["media_consumption_id"], name: "index_media_sessions_on_media_consumption_id", using: :btree

  create_table "media_work_badges", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "media_work_id", limit: 4
    t.integer  "badge_id",      limit: 4
  end

  add_index "media_work_badges", ["badge_id"], name: "index_media_work_badges_on_badge_id", using: :btree
  add_index "media_work_badges", ["media_work_id"], name: "index_media_work_badges_on_media_work_id", using: :btree

  create_table "media_works", force: :cascade do |t|
    t.string   "medium",     limit: 255, null: false
    t.string   "title",      limit: 255, null: false
    t.boolean  "perennial"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "media_works", ["medium"], name: "index_media_works_on_medium", using: :btree
  add_index "media_works", ["title"], name: "index_media_works_on_title", using: :btree

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

  create_table "sessions", force: :cascade do |t|
    t.string   "session_token", limit: 255
    t.integer  "user_id",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_token"], name: "index_sessions_on_session_token", using: :btree
  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id", using: :btree

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
