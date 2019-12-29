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

ActiveRecord::Schema.define(version: 2019_12_29_174152) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.string "session_token"
    t.integer "region_id"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["region_id"], name: "index_admins_on_region_id"
    t.index ["session_token"], name: "index_admins_on_session_token", unique: true
  end

  create_table "alarms", id: :serial, force: :cascade do |t|
    t.integer "region_id"
    t.string "push_identifier"
    t.string "message"
    t.string "secure_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stop_id"
    t.string "trip_id"
    t.bigint "service_date"
    t.string "vehicle_id"
    t.integer "stop_sequence"
    t.integer "seconds_before", default: 600, null: false
    t.index ["push_identifier"], name: "index_alarms_on_push_identifier"
    t.index ["region_id"], name: "index_alarms_on_region_id"
    t.index ["secure_token"], name: "index_alarms_on_secure_token", unique: true
  end

  create_table "alert_feed_items", id: :serial, force: :cascade do |t|
    t.integer "alert_feed_id", null: false
    t.string "title"
    t.string "url"
    t.text "summary"
    t.datetime "starts_at"
    t.string "external_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "priority", default: 0
    t.boolean "test_item", default: true, null: false
    t.datetime "ends_at"
    t.integer "cause", default: 0, null: false
    t.integer "effect", default: 7, null: false
    t.integer "severity", default: 1
    t.index ["alert_feed_id"], name: "index_alert_feed_items_on_alert_feed_id"
  end

  create_table "alert_feeds", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "url"
    t.datetime "last_fetched"
    t.integer "region_id"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_alert_feeds_on_region_id"
    t.index ["url"], name: "index_alert_feeds_on_url", unique: true
  end

  create_table "regions", id: :serial, force: :cascade do |t|
    t.integer "region_identifier"
    t.string "api_url"
    t.string "web_url"
    t.string "name"
    t.jsonb "bounds_list", default: "[]", null: false
    t.integer "manual_feed_id"
    t.index ["manual_feed_id"], name: "index_regions_on_manual_feed_id"
    t.index ["region_identifier"], name: "index_regions_on_region_identifier", unique: true
  end

end
