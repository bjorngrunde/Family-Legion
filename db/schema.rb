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

ActiveRecord::Schema.define(version: 20161209124152) do

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

end
