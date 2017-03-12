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

ActiveRecord::Schema.define(version: 20170311235106) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alarms", force: :cascade do |t|
    t.integer  "region_id"
    t.string   "push_identifier"
    t.string   "message"
    t.string   "secure_token"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "stop_id"
    t.string   "trip_id"
    t.bigint   "service_date"
    t.string   "vehicle_id"
    t.integer  "stop_sequence"
    t.index ["push_identifier"], name: "index_alarms_on_push_identifier", using: :btree
    t.index ["region_id"], name: "index_alarms_on_region_id", using: :btree
    t.index ["secure_token"], name: "index_alarms_on_secure_token", unique: true, using: :btree
  end

  create_table "alert_feed_items", force: :cascade do |t|
    t.integer  "alert_feed_id", null: false
    t.string   "title"
    t.string   "url"
    t.text     "summary"
    t.datetime "published_at"
    t.string   "external_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "alert_feeds", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "url"
    t.datetime "last_fetched"
    t.integer  "region_id"
    t.string   "type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "regions", force: :cascade do |t|
    t.integer "region_identifier"
    t.string  "api_url"
    t.string  "web_url"
    t.string  "name"
    t.index ["region_identifier"], name: "index_regions_on_region_identifier", unique: true, using: :btree
  end

end
