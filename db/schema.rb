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

  create_table "bubbles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name",                             null: false
    t.string   "artist",                           null: false
    t.string   "medium",                           null: false
    t.integer  "radius"
    t.text     "thoughts",           limit: 65535
    t.text     "spoiler_thoughts",   limit: 65535
    t.date     "finish_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["artist"], name: "index_bubbles_on_artist", using: :btree
    t.index ["medium"], name: "index_bubbles_on_medium", using: :btree
    t.index ["name"], name: "index_bubbles_on_name", using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "day_id",                                     null: false
    t.string   "author"
    t.string   "author_email"
    t.text     "body",         limit: 65535,                 null: false
    t.datetime "date"
    t.integer  "parent_id",                  default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved",                   default: true
    t.boolean  "rejected",                   default: false
    t.index ["approved"], name: "index_comments_on_approved", using: :btree
    t.index ["day_id"], name: "index_comments_on_day_id", using: :btree
    t.index ["parent_id"], name: "index_comments_on_parent_id", using: :btree
    t.index ["rejected"], name: "index_comments_on_rejected", using: :btree
  end

  create_table "days", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "title"
    t.integer  "number",                                           null: false
    t.datetime "publish_date"
    t.text     "body",               limit: 65535
    t.string   "slug"
    t.text     "mouseover",          limit: 65535
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
    t.boolean  "is_draft",                         default: false, null: false
    t.index ["day_of"], name: "index_days_on_day_of", using: :btree
    t.index ["is_draft"], name: "index_days_on_is_draft", using: :btree
    t.index ["number"], name: "index_days_on_number", unique: true, using: :btree
    t.index ["slug"], name: "index_days_on_slug", unique: true, using: :btree
    t.index ["title"], name: "index_days_on_title", using: :btree
    t.index ["whisper"], name: "index_days_on_whisper", unique: true, using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "legacy_taggings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "day_id",     null: false
    t.integer  "tag_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["day_id"], name: "index_legacy_taggings_on_day_id", using: :btree
    t.index ["tag_id"], name: "index_legacy_taggings_on_tag_id", using: :btree
  end

  create_table "legacy_tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name",       null: false
    t.string   "tag_type",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "tag_type"], name: "index_legacy_tags_on_name_and_tag_type", unique: true, using: :btree
  end

  create_table "people", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_people_on_name", unique: true, using: :btree
  end

  create_table "photos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "day_id"
    t.boolean  "is_canonical"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.index ["day_id"], name: "index_photos_on_day_id", using: :btree
    t.index ["is_canonical"], name: "index_photos_on_is_canonical", using: :btree
  end

  create_table "taggings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "day_id",     null: false
    t.integer  "tag_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["day_id"], name: "index_taggings_on_day_id", using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name",                           null: false
    t.integer  "parent_id"
    t.integer  "lft",                            null: false
    t.integer  "rgt",                            null: false
    t.integer  "depth",          default: 0,     null: false
    t.integer  "children_count", default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "featured",       default: false
    t.index ["depth"], name: "index_tags_on_depth", using: :btree
    t.index ["featured"], name: "index_tags_on_featured", using: :btree
    t.index ["lft"], name: "index_tags_on_lft", using: :btree
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
    t.index ["parent_id"], name: "index_tags_on_parent_id", using: :btree
    t.index ["rgt"], name: "index_tags_on_rgt", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name",                          null: false
    t.boolean  "is_admin",      default: false
    t.string   "password_hash"
    t.string   "session_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_users_on_name", unique: true, using: :btree
    t.index ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree
  end

end
