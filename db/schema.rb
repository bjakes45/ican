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

ActiveRecord::Schema.define(version: 20180803135048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "candidates", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "position_id"
    t.boolean  "deactivate",    default: false
    t.datetime "deactivate_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["position_id"], name: "index_candidates_on_position_id", using: :btree
    t.index ["user_id"], name: "index_candidates_on_user_id", using: :btree
  end

  create_table "council_categories", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_council_categories_on_user_id", using: :btree
  end

  create_table "council_settings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "council_id"
    t.integer  "memb_vote_threshold", default: 50
    t.integer  "min_mot_vote",        default: 10
    t.integer  "campaign_length",     default: 30
    t.integer  "enactment_delay",     default: 45
    t.string   "membership_area",     default: "Global"
    t.string   "membership_distance"
    t.boolean  "deactivate",          default: false
    t.datetime "deactivate_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["council_id"], name: "index_council_settings_on_council_id", using: :btree
    t.index ["user_id"], name: "index_council_settings_on_user_id", using: :btree
  end

  create_table "councils", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.integer  "user_id"
    t.integer  "council_category_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["council_category_id"], name: "index_councils_on_council_category_id", using: :btree
    t.index ["user_id"], name: "index_councils_on_user_id", using: :btree
  end

  create_table "incumbents", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "position_id"
    t.boolean  "active",        default: false
    t.datetime "active_at"
    t.boolean  "deactivate",    default: false
    t.datetime "deactivate_at"
    t.boolean  "elected",       default: false
    t.datetime "elected_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["position_id"], name: "index_incumbents_on_position_id", using: :btree
    t.index ["user_id"], name: "index_incumbents_on_user_id", using: :btree
  end

  create_table "memb_votes", force: :cascade do |t|
    t.string   "vote"
    t.integer  "user_id"
    t.integer  "membership_id"
    t.boolean  "deactivate",    default: false
    t.datetime "deactivate_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["membership_id"], name: "index_memb_votes_on_membership_id", using: :btree
    t.index ["user_id"], name: "index_memb_votes_on_user_id", using: :btree
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "council_id"
    t.boolean  "active",        default: false
    t.datetime "active_at"
    t.boolean  "deactivate",    default: false
    t.datetime "deactivate_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["council_id"], name: "index_memberships_on_council_id", using: :btree
    t.index ["user_id"], name: "index_memberships_on_user_id", using: :btree
  end

  create_table "mot_votes", force: :cascade do |t|
    t.string   "vote"
    t.integer  "user_id"
    t.integer  "post_id"
    t.boolean  "deactivate",    default: false
    t.datetime "deactivate_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["post_id"], name: "index_mot_votes_on_post_id", using: :btree
    t.index ["user_id"], name: "index_mot_votes_on_user_id", using: :btree
  end

  create_table "policies", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.boolean  "active",        default: false
    t.datetime "active_at"
    t.boolean  "deactivate",    default: false
    t.datetime "deactivate_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["post_id"], name: "index_policies_on_post_id", using: :btree
    t.index ["user_id"], name: "index_policies_on_user_id", using: :btree
  end

  create_table "pos_votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "position_id"
    t.integer  "vote_id"
    t.boolean  "active",        default: false
    t.datetime "active_at"
    t.boolean  "deactivate",    default: false
    t.datetime "deactivate_at"
    t.boolean  "decline",       default: false
    t.datetime "decline_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["position_id"], name: "index_pos_votes_on_position_id", using: :btree
    t.index ["user_id"], name: "index_pos_votes_on_user_id", using: :btree
    t.index ["vote_id"], name: "index_pos_votes_on_vote_id", using: :btree
  end

  create_table "positions", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "council_id"
    t.boolean  "active",        default: false
    t.datetime "active_at"
    t.boolean  "deactivate",    default: false
    t.datetime "deactivate_at"
    t.boolean  "appointed",     default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["council_id"], name: "index_positions_on_council_id", using: :btree
    t.index ["user_id"], name: "index_positions_on_user_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "parent_post_id"
    t.integer  "user_id"
    t.integer  "council_id"
    t.boolean  "closed",         default: true
    t.boolean  "motion",         default: false
    t.boolean  "deactivate",     default: false
    t.datetime "deactivate_at"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["council_id"], name: "index_posts_on_council_id", using: :btree
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "private_conversations", force: :cascade do |t|
    t.integer  "recipient_id"
    t.integer  "sender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["recipient_id", "sender_id"], name: "index_private_conversations_on_recipient_id_and_sender_id", unique: true, using: :btree
    t.index ["recipient_id"], name: "index_private_conversations_on_recipient_id", using: :btree
    t.index ["sender_id"], name: "index_private_conversations_on_sender_id", using: :btree
  end

  create_table "private_messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.boolean  "seen",            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["conversation_id"], name: "index_private_messages_on_conversation_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   default: "", null: false
    t.string   "country",                default: "", null: false
    t.string   "state",                  default: "", null: false
    t.string   "city",                   default: "", null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "private_messages", "users"
end
