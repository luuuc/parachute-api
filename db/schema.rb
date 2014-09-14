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

ActiveRecord::Schema.define(version: 20140913093756) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "uuid-ossp"

  create_table "apps", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name",                         null: false
    t.string   "api_key",                      null: false
    t.hstore   "repository_data", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apps", ["api_key"], name: "index_apps_on_api_key", unique: true, using: :btree
  add_index "apps", ["name"], name: "index_apps_on_name", unique: true, using: :btree

  create_table "backtraces", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "issue_id"
    t.integer  "line"
    t.string   "location"
    t.string   "method"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "invited_by",                      null: false
    t.uuid     "invited_user_id"
    t.string   "name",                            null: false
    t.string   "email",                           null: false
    t.boolean  "admin",           default: false
    t.hstore   "settings_data",   default: "",    null: false
    t.string   "token",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["email"], name: "index_invitations_on_email", unique: true, using: :btree
  add_index "invitations", ["token"], name: "index_invitations_on_token", unique: true, using: :btree

  create_table "issues", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "app_id"
    t.string   "fingerprint"
    t.integer  "status"
    t.string   "error_class"
    t.string   "message"
    t.string   "environment_name",   default: "unknown"
    t.string   "framework",          default: "unknown"
    t.integer  "occurences_count",   default: 0
    t.datetime "first_occurence_at"
    t.datetime "last_occurence_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "issues", ["app_id", "fingerprint"], name: "index_issues_on_app_id_and_fingerprint", unique: true, using: :btree
  add_index "issues", ["app_id"], name: "index_issues_on_app_id", using: :btree

  create_table "occurences", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "issue_id"
    t.string   "fingerprint"
    t.hstore   "notifier_data"
    t.hstore   "server_data"
    t.hstore   "request_data"
    t.hstore   "environment_data"
    t.hstore   "session_data"
    t.hstore   "user_data"
    t.hstore   "additional_data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "occurences", ["issue_id"], name: "index_occurences_on_issue_id", using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.boolean  "admin",                      default: false
    t.string   "name",                                       null: false
    t.string   "email",                                      null: false
    t.hstore   "settings_data",              default: "",    null: false
    t.string   "password_digest",                            null: false
    t.string   "authentication_token",                       null: false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "unconfirmed_email"
    t.string   "email_confirmation_token"
    t.datetime "email_confirmation_sent_at"
    t.boolean  "active",                     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree

  create_table "watchers", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "user_id"
    t.uuid     "app_id"
    t.boolean  "notify",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
