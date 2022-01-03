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

ActiveRecord::Schema.define(version: 2022_01_02_145358) do

  create_table "channels", force: :cascade do |t|
    t.string "name"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_channels_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "comment"
    t.integer "user_id"
    t.integer "video_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_comments_on_user_id"
    t.index ["video_id"], name: "index_comments_on_video_id"
  end

  create_table "good_or_bads", force: :cascade do |t|
    t.integer "user_id"
    t.integer "video_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "evaluation"
    t.index ["user_id"], name: "index_good_or_bads_on_user_id"
    t.index ["video_id"], name: "index_good_or_bads_on_video_id"
  end

  create_table "histories", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "video_id", null: false
    t.index ["user_id"], name: "index_histories_on_user_id"
    t.index ["video_id"], name: "index_histories_on_video_id"
  end

  create_table "one_day_views", force: :cascade do |t|
    t.integer "video_id", null: false
    t.integer "count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["video_id"], name: "index_one_day_views_on_video_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag_name"
    t.integer "video_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["video_id"], name: "index_tags_on_video_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password"
  end

  create_table "video_tags", force: :cascade do |t|
    t.integer "video_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tag_id"], name: "index_video_tags_on_tag_id"
    t.index ["video_id"], name: "index_video_tags_on_video_id"
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "channel_id"
    t.string "thumbnail"
    t.integer "category"
    t.index ["channel_id"], name: "index_videos_on_channel_id"
  end

  create_table "views", force: :cascade do |t|
    t.integer "count", default: 0
    t.integer "video_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "channels", "users"
  add_foreign_key "histories", "users"
  add_foreign_key "histories", "videos"
  add_foreign_key "one_day_views", "videos"
  add_foreign_key "tags", "videos"
  add_foreign_key "video_tags", "tags"
  add_foreign_key "video_tags", "videos"
  add_foreign_key "videos", "channels"
end
