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

ActiveRecord::Schema.define(version: 20170513143903) do

  create_table "alts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username"
    t.integer  "user_id"
    t.string   "thumbnail"
    t.integer  "klass"
    t.string   "server"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_alts_on_username", unique: true, using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.integer  "user_id"
    t.text     "body",             limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "dungeons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "dungeon_type"
    t.text     "image_meta_data", limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "description", limit: 65535
    t.integer  "difficulty"
    t.boolean  "public",                    default: false
    t.boolean  "guild_event",               default: false
    t.string   "start_time"
    t.string   "end_time"
    t.date     "start_date"
    t.integer  "dungeon_id"
    t.integer  "user_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["dungeon_id"], name: "index_events_on_dungeon_id", using: :btree
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
  end

  create_table "forum_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "description"
    t.string   "role"
    t.integer  "forum_group_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "slug"
    t.index ["slug"], name: "index_forum_categories_on_slug", unique: true, using: :btree
    t.index ["title"], name: "index_forum_categories_on_title", unique: true, using: :btree
  end

  create_table "forum_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "body",              limit: 65535
    t.integer  "user_id"
    t.integer  "forum_group_id"
    t.integer  "forum_category_id"
    t.integer  "forum_thread_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["forum_category_id"], name: "index_forum_comments_on_forum_category_id", using: :btree
    t.index ["forum_group_id"], name: "index_forum_comments_on_forum_group_id", using: :btree
    t.index ["forum_thread_id"], name: "index_forum_comments_on_forum_thread_id", using: :btree
    t.index ["user_id"], name: "index_forum_comments_on_user_id", using: :btree
  end

  create_table "forum_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.index ["slug"], name: "index_forum_groups_on_slug", unique: true, using: :btree
    t.index ["title"], name: "index_forum_groups_on_title", unique: true, using: :btree
  end

  create_table "forum_threads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "body",                 limit: 65535
    t.integer  "forum_group_id"
    t.integer  "forum_category_id"
    t.integer  "user_id"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "pinned",                             default: false
    t.integer  "forum_comments_count"
    t.boolean  "is_locked",                          default: false
    t.index ["forum_category_id"], name: "index_forum_threads_on_forum_category_id", using: :btree
    t.index ["forum_group_id"], name: "index_forum_threads_on_forum_group_id", using: :btree
    t.index ["slug", "title"], name: "index_forum_threads_on_slug_and_title", unique: true, using: :btree
    t.index ["slug"], name: "index_forum_threads_on_slug", unique: true, using: :btree
    t.index ["user_id"], name: "index_forum_threads_on_user_id", using: :btree
  end

  create_table "guild_applications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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

  create_table "image_managers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.text     "image_meta_data", limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["user_id"], name: "index_image_managers_on_user_id", using: :btree
  end

  create_table "invites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "inviteable_type"
    t.integer  "inviteable_id"
    t.string   "notice"
    t.integer  "role"
    t.integer  "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["inviteable_type", "inviteable_id"], name: "index_invites_on_inviteable_type_and_inviteable_id", using: :btree
  end

  create_table "profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username"
    t.string   "email"
    t.text     "auth_meta_data", limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["email", "username"], name: "index_users_on_email_and_username", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  create_table "views", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "viewable_type"
    t.integer  "viewable_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["viewable_type", "viewable_id"], name: "index_views_on_viewable_type_and_viewable_id", using: :btree
  end

end
