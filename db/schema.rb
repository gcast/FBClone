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

ActiveRecord::Schema.define(version: 20140422182844) do

  create_table "friend_requests", force: true do |t|
    t.integer  "requestorID"
    t.integer  "requesteeID"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: true do |t|
    t.integer  "userID"
    t.integer  "friendID"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["friendID"], name: "index_friendships_on_friendID"
  add_index "friendships", ["userID", "friendID"], name: "index_friendships_on_userid_and_friendid", unique: true
  add_index "friendships", ["userID"], name: "index_friendships_on_userID"

  create_table "post_tags", force: true do |t|
    t.integer  "post_id",        null: false
    t.integer  "tagged_user_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_tags", ["post_id", "tagged_user_id"], name: "index_post_tags_on_post_id_and_tagged_user_id", unique: true
  add_index "post_tags", ["post_id"], name: "index_post_tags_on_post_id"
  add_index "post_tags", ["tagged_user_id"], name: "index_post_tags_on_tagged_user_id"

  create_table "posts", force: true do |t|
    t.text     "body"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recipient_id"
  end

  add_index "posts", ["author_id"], name: "index_posts_on_author_id"

  create_table "users", force: true do |t|
    t.string   "firstName",       null: false
    t.string   "lastName",        null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.date     "birthDate",       null: false
    t.string   "session_token",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
