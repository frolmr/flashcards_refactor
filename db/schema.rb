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

ActiveRecord::Schema.define(version: 20170102155622) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid", using: :btree
  end

  create_table "blocks", force: :cascade do |t|
    t.string   "title",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    null: false
  end

  create_table "cards", force: :cascade do |t|
    t.text     "original_text"
    t.text     "translated_text"
    t.datetime "review_date",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                       null: false
    t.string   "image"
    t.integer  "block_id",                      null: false
    t.integer  "interval",        default: 1,   null: false
    t.integer  "repeat",          default: 1,   null: false
    t.float    "efactor",         default: 2.5, null: false
    t.integer  "attempt",         default: 1,   null: false
    t.integer  "quality",         default: 5,   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer  "current_block_id"
    t.string   "locale"
    t.boolean  "admin"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree
  end

end
