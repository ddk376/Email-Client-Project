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

ActiveRecord::Schema.define(version: 20151018062831) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "electronic_mails", force: :cascade do |t|
    t.integer  "email_thread_id",                 null: false
    t.integer  "parent_email_id"
    t.string   "from",                            null: false
    t.text     "body"
    t.boolean  "is_important",    default: false
    t.boolean  "is_starred",      default: false
    t.boolean  "is_draft",        default: false
    t.boolean  "is_trash",        default: false
    t.boolean  "is_archived",     default: false
    t.boolean  "is_read",         default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "email_threads", force: :cascade do |t|
    t.string   "subject"
    t.integer  "owner_id",                   null: false
    t.boolean  "is_checked", default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "email_threads", ["owner_id"], name: "index_email_threads_on_owner_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

end
