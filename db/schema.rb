# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_09_04_160018) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.string "session_token"
    t.integer "region_id"
    t.string "reset_digest"
    t.datetime "reset_sent_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["region_id"], name: "index_admins_on_region_id"
    t.index ["session_token"], name: "index_admins_on_session_token", unique: true
  end

  create_table "alarms", id: :serial, force: :cascade do |t|
    t.integer "region_id"
    t.string "push_identifier"
    t.string "message"
    t.string "secure_token"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
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
    t.datetime "starts_at", precision: nil
    t.string "external_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "priority", default: 0
    t.boolean "test_item", default: true, null: false
    t.datetime "ends_at", precision: nil
    t.integer "cause", default: 0, null: false
    t.integer "effect", default: 7, null: false
    t.integer "severity", default: 1
    t.index ["alert_feed_id"], name: "index_alert_feed_items_on_alert_feed_id"
  end

  create_table "alert_feeds", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "url"
    t.datetime "last_fetched", precision: nil
    t.integer "region_id"
    t.string "type"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["region_id"], name: "index_alert_feeds_on_region_id"
    t.index ["url"], name: "index_alert_feeds_on_url", unique: true
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "survey_id", null: false
    t.jsonb "content", default: {}, null: false
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["position"], name: "index_questions_on_position"
    t.index ["survey_id", "position"], name: "index_questions_on_survey_id_and_position", unique: true
    t.index ["survey_id"], name: "index_questions_on_survey_id"
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

  create_table "studies", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "region_id", null: false
    t.jsonb "extra_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_studies_on_region_id"
  end

  create_table "survey_responses", force: :cascade do |t|
    t.bigint "survey_id", null: false
    t.string "user_identifier", null: false
    t.string "public_identifier", null: false
    t.jsonb "responses", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stop_identifier"
    t.index ["public_identifier"], name: "index_survey_responses_on_public_identifier", unique: true
    t.index ["stop_identifier"], name: "index_survey_responses_on_stop_identifier"
    t.index ["survey_id"], name: "index_survey_responses_on_survey_id"
    t.index ["user_identifier"], name: "index_survey_responses_on_user_identifier"
  end

  create_table "surveys", force: :cascade do |t|
    t.bigint "study_id", null: false
    t.boolean "available", default: true
    t.jsonb "extra_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["available"], name: "index_surveys_on_available"
    t.index ["study_id"], name: "index_surveys_on_study_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "questions", "surveys"
  add_foreign_key "studies", "regions"
  add_foreign_key "survey_responses", "surveys"
  add_foreign_key "surveys", "studies"
end
