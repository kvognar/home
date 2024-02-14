# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_08_14_051131) do

  create_table "badges", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name"
    t.string "symbol"
    t.string "description"
    t.index ["name"], name: "index_badges_on_name"
  end

  create_table "comments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "day_id", null: false
    t.string "author"
    t.string "author_email"
    t.text "body", null: false
    t.datetime "date"
    t.integer "parent_id", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "approved", default: true
    t.boolean "rejected", default: false
    t.index ["approved"], name: "index_comments_on_approved"
    t.index ["day_id"], name: "index_comments_on_day_id"
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["rejected"], name: "index_comments_on_rejected"
  end

  create_table "days", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "title"
    t.integer "number", null: false
    t.datetime "publish_date"
    t.text "body"
    t.string "slug"
    t.text "mouseover"
    t.string "lyrics"
    t.string "lyric_credit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.bigint "photo_file_size"
    t.datetime "photo_updated_at"
    t.string "whisper"
    t.date "day_of"
    t.boolean "is_draft", default: false, null: false
    t.boolean "favorite", default: false, null: false
    t.index ["day_of"], name: "index_days_on_day_of"
    t.index ["is_draft"], name: "index_days_on_is_draft"
    t.index ["number"], name: "index_days_on_number", unique: true
    t.index ["slug"], name: "index_days_on_slug", unique: true
    t.index ["title"], name: "index_days_on_title"
    t.index ["whisper"], name: "index_days_on_whisper", unique: true
  end

  create_table "friendly_id_slugs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "legacy_taggings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "day_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["day_id"], name: "index_legacy_taggings_on_day_id"
    t.index ["tag_id"], name: "index_legacy_taggings_on_tag_id"
  end

  create_table "legacy_tags", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "tag_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "tag_type"], name: "index_legacy_tags_on_name_and_tag_type", unique: true
  end

  create_table "media_consumptions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "media_work_id"
    t.datetime "start_date"
    t.datetime "finish_date"
    t.boolean "revisiting"
    t.string "state", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["finish_date"], name: "index_media_consumptions_on_finish_date"
    t.index ["start_date"], name: "index_media_consumptions_on_start_date"
    t.index ["state"], name: "index_media_consumptions_on_state"
  end

  create_table "media_creator_works", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "media_creator_id"
    t.integer "media_work_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["media_creator_id"], name: "index_media_creator_works_on_media_creator_id"
    t.index ["media_work_id"], name: "index_media_creator_works_on_media_work_id"
  end

  create_table "media_creators", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_media_creators_on_name"
  end

  create_table "media_images", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "attachable_id", null: false
    t.integer "attachable_type", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "media_sessions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "day_id"
    t.integer "media_consumption_id", null: false
    t.string "title"
    t.text "text"
    t.text "spoiler_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["day_id"], name: "index_media_sessions_on_day_id"
    t.index ["media_consumption_id"], name: "index_media_sessions_on_media_consumption_id"
  end

  create_table "media_taggings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "media_work_id"
    t.integer "media_tag_id"
    t.index ["media_tag_id"], name: "index_media_taggings_on_media_tag_id"
    t.index ["media_work_id"], name: "index_media_taggings_on_media_work_id"
  end

  create_table "media_tags", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name"
    t.integer "lft"
    t.integer "rgt"
    t.integer "parent_id"
    t.integer "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["depth"], name: "index_media_tags_on_depth"
    t.index ["lft"], name: "index_media_tags_on_lft"
    t.index ["name"], name: "index_media_tags_on_name"
    t.index ["parent_id"], name: "index_media_tags_on_parent_id"
    t.index ["rgt"], name: "index_media_tags_on_rgt"
  end

  create_table "media_work_badges", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "media_work_id"
    t.integer "badge_id"
    t.index ["badge_id"], name: "index_media_work_badges_on_badge_id"
    t.index ["media_work_id"], name: "index_media_work_badges_on_media_work_id"
  end

  create_table "media_works", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "medium", null: false
    t.string "title", null: false
    t.boolean "perennial"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "recommended_by"
    t.text "recommended_because"
    t.index ["medium"], name: "index_media_works_on_medium"
    t.index ["title"], name: "index_media_works_on_title"
  end

  create_table "people", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_people_on_name", unique: true
  end

  create_table "photos", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "day_id"
    t.boolean "is_canonical"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.bigint "photo_file_size"
    t.datetime "photo_updated_at"
    t.text "alt_text"
    t.index ["day_id"], name: "index_photos_on_day_id"
    t.index ["is_canonical"], name: "index_photos_on_is_canonical"
  end

  create_table "sessions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "session_token"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_token"], name: "index_sessions_on_session_token"
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "taggings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "day_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["day_id"], name: "index_taggings_on_day_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.integer "parent_id"
    t.integer "lft", null: false
    t.integer "rgt", null: false
    t.integer "depth", default: 0, null: false
    t.integer "children_count", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "featured", default: false
    t.boolean "content_warning", default: false
    t.index ["depth"], name: "index_tags_on_depth"
    t.index ["featured"], name: "index_tags_on_featured"
    t.index ["lft"], name: "index_tags_on_lft"
    t.index ["name"], name: "index_tags_on_name", unique: true
    t.index ["parent_id"], name: "index_tags_on_parent_id"
    t.index ["rgt"], name: "index_tags_on_rgt"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "is_admin", default: false
    t.string "password_hash"
    t.string "session_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["session_token"], name: "index_users_on_session_token", unique: true
  end

end
