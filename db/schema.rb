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

ActiveRecord::Schema.define(version: 20140428161707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: true do |t|
    t.integer  "owner_id",   null: false
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "albums", ["owner_id"], name: "index_albums_on_owner_id", using: :btree

  create_table "comments", force: true do |t|
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["author_id"], name: "index_comments_on_author_id", using: :btree

  create_table "friend_group_joins", force: true do |t|
    t.integer  "group_id",   null: false
    t.integer  "friend_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friend_group_joins", ["friend_id"], name: "index_friend_group_joins_on_friend_id", using: :btree
  add_index "friend_group_joins", ["group_id"], name: "index_friend_group_joins_on_group_id", using: :btree

  create_table "friend_groups", force: true do |t|
    t.string   "group_name"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friend_groups", ["owner_id"], name: "index_friend_groups_on_owner_id", using: :btree

  create_table "friend_requests", force: true do |t|
    t.integer  "requestor_id"
    t.integer  "requestee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["friend_id"], name: "index_friendships_on_friend_id", using: :btree
  add_index "friendships", ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true, using: :btree
  add_index "friendships", ["user_id"], name: "index_friendships_on_user_id", using: :btree

  create_table "likes", force: true do |t|
    t.integer  "liker_id"
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["liker_id"], name: "index_likes_on_liker_id", using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_read?",        default: false
  end

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_tags", force: true do |t|
    t.integer  "post_id",        null: false
    t.integer  "tagged_user_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_tags", ["post_id", "tagged_user_id"], name: "index_post_tags_on_post_id_and_tagged_user_id", unique: true, using: :btree
  add_index "post_tags", ["post_id"], name: "index_post_tags_on_post_id", using: :btree
  add_index "post_tags", ["tagged_user_id"], name: "index_post_tags_on_tagged_user_id", using: :btree

  create_table "posts", force: true do |t|
    t.text     "body"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recipient_id"
  end

  add_index "posts", ["author_id"], name: "index_posts_on_author_id", using: :btree

  create_table "shares", force: true do |t|
    t.integer  "group_id",       null: false
    t.integer  "shareable_id"
    t.string   "shareable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shares", ["group_id"], name: "index_shares_on_group_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.date     "birthDate",       null: false
    t.string   "session_token",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
