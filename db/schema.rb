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

ActiveRecord::Schema.define(version: 20160710142852) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beers", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.decimal  "alcohol"
    t.decimal  "extract"
    t.decimal  "volume"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "pub_id"
    t.string   "text"
    t.integer  "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["pub_id"], name: "index_comments_on_pub_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "pub_id"
    t.string   "name"
    t.datetime "date"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "events", ["pub_id"], name: "index_events_on_pub_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "notifications", ["event_id"], name: "index_notifications_on_event_id", using: :btree

  create_table "offers", force: :cascade do |t|
    t.integer  "pub_id"
    t.integer  "beer_id"
    t.decimal  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "offers", ["beer_id"], name: "index_offers_on_beer_id", using: :btree
  add_index "offers", ["pub_id"], name: "index_offers_on_pub_id", using: :btree

  create_table "pubs", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "phone"
    t.string   "email"
    t.boolean  "hidden"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "pub_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subscriptions", ["pub_id"], name: "index_subscriptions_on_pub_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "login"
    t.string   "email"
    t.string   "password"
    t.string   "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "comments", "pubs"
  add_foreign_key "events", "pubs"
  add_foreign_key "notifications", "events"
  add_foreign_key "offers", "beers"
  add_foreign_key "offers", "pubs"
  add_foreign_key "subscriptions", "pubs"
  add_foreign_key "subscriptions", "users"
end
