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

ActiveRecord::Schema.define(version: 20170305212713) do

  create_table "alts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "username"
    t.integer  "user_id"
    t.string   "thumbnail"
    t.integer  "klass"
    t.string   "server"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_alts_on_username", unique: true, using: :btree
  end

  create_table "guild_applications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "username"
    t.string   "server"
    t.string   "spec"
    t.string   "armory"
    t.integer  "klass"
    t.text     "played",          limit: 65535
    t.text     "klass_played",    limit: 65535
    t.text     "bio",             limit: 65535
    t.text     "raid_experience", limit: 65535
    t.text     "reason",          limit: 65535
    t.text     "old_guild",       limit: 65535
    t.text     "progress_raid",   limit: 65535
    t.text     "attendance",      limit: 65535
    t.text     "image_meta_data", limit: 65535
    t.text     "other",           limit: 65535
    t.integer  "status"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["email", "username"], name: "index_guild_applications_on_email_and_username", unique: true, using: :btree
  end

  create_table "profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "user_id",                                     null: false
    t.string   "first_name",        limit: 45
    t.string   "last_name",         limit: 45
    t.integer  "klass"
    t.string   "server"
    t.string   "avatar"
    t.string   "thumbnail"
    t.string   "phone"
    t.integer  "rank",                            default: 1
    t.integer  "rate",                            default: 1
    t.string   "spec"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.text     "profile_meta_data", limit: 65535
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "username"
    t.string   "email"
    t.text     "auth_meta_data", limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["email", "username"], name: "index_users_on_email_and_username", unique: true, using: :btree
  end

end
