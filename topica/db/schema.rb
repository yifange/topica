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

ActiveRecord::Schema.define(version: 20131018004603) do

  create_table "comments", force: true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "favors", force: true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favors", ["post_id"], name: "index_favors_on_post_id", using: :btree
  add_index "favors", ["user_id"], name: "index_favors_on_user_id", using: :btree

  create_table "feeds", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feeds", ["user_id"], name: "index_feeds_on_user_id", using: :btree

  create_table "followships", force: true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "followships", ["topic_id"], name: "index_followships_on_topic_id", using: :btree
  add_index "followships", ["user_id"], name: "index_followships_on_user_id", using: :btree

  create_table "posts", force: true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.text     "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["topic_id"], name: "index_posts_on_topic_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "topics", force: true do |t|
    t.integer  "user_id"
    t.integer  "feed_id"
    t.string   "name"
    t.integer  "topic_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["feed_id"], name: "index_topics_on_feed_id", using: :btree
  add_index "topics", ["user_id"], name: "index_topics_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
