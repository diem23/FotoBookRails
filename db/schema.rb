# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_07_22_041605) do
  create_table "albums", charset: "utf8mb3", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.boolean "isPrivate"
    t.integer "numOfLikes"
    t.integer "numOfPhotos"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_albums_on_user_id"
  end

  create_table "follows", charset: "utf8mb3", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_follows_on_followed_id"
    t.index ["follower_id"], name: "index_follows_on_follower_id"
  end

  create_table "photos", charset: "utf8mb3", force: :cascade do |t|
    t.string "image"
    t.string "title"
    t.string "description"
    t.boolean "isPrivate"
    t.integer "numOfLikes"
    t.bigint "user_id"
    t.bigint "album_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_photos_on_album_id"
    t.index ["user_id"], name: "index_photos_on_user_id"
  end

  create_table "react_albums", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "album_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_react_albums_on_album_id"
    t.index ["user_id"], name: "index_react_albums_on_user_id"
  end

  create_table "react_photos", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "photo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["photo_id"], name: "index_react_photos_on_photo_id"
    t.index ["user_id"], name: "index_react_photos_on_user_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "profileImg"
    t.string "firstName"
    t.string "lastName"
    t.string "email"
    t.boolean "isActive"
    t.boolean "isAdmin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "provider"
    t.string "uid"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "albums", "users"
  add_foreign_key "photos", "albums"
  add_foreign_key "photos", "users"
  add_foreign_key "react_albums", "albums"
  add_foreign_key "react_albums", "users"
  add_foreign_key "react_photos", "photos"
  add_foreign_key "react_photos", "users"
end
