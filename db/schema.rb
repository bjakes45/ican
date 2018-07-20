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

ActiveRecord::Schema.define(version: 20180718032507) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "council_categories", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "council_categories", ["user_id"], name: "index_council_categories_on_user_id", using: :btree

  create_table "councils", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "council_category_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "councils", ["council_category_id"], name: "index_councils_on_council_category_id", using: :btree
  add_index "councils", ["user_id"], name: "index_councils_on_user_id", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "council_id"
    t.boolean  "active",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "memberships", ["council_id"], name: "index_memberships_on_council_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "pos_votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "position_id"
    t.integer  "vote_id"
    t.boolean  "active",      default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "pos_votes", ["position_id"], name: "index_pos_votes_on_position_id", using: :btree
  add_index "pos_votes", ["user_id"], name: "index_pos_votes_on_user_id", using: :btree
  add_index "pos_votes", ["vote_id"], name: "index_pos_votes_on_vote_id", using: :btree

  create_table "positions", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "council_id"
    t.boolean  "active",      default: false
    t.boolean  "appointed",   default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "positions", ["council_id"], name: "index_positions_on_council_id", using: :btree
  add_index "positions", ["user_id"], name: "index_positions_on_user_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "council_id"
    t.boolean  "closed",     default: true
    t.boolean  "motion",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "posts", ["council_id"], name: "index_posts_on_council_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
