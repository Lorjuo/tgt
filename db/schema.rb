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

ActiveRecord::Schema.define(version: 20151113091612) do

  create_table "announcements", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.text     "caption",      limit: 65535
    t.string   "url",          limit: 255
    t.boolean  "active",                     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "visible_from"
    t.date     "visible_to"
    t.integer  "position",     limit: 4
  end

  create_table "areas", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carnival_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "price",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carnival_orders", primary_key: "order_id", force: :cascade do |t|
    t.integer  "person_id",  limit: 4
    t.string   "notice",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carnival_people", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "street",     limit: 255
    t.string   "zip",        limit: 255
    t.string   "city",       limit: 255
    t.string   "email",      limit: 255
    t.string   "phone",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carnival_reservations", force: :cascade do |t|
    t.integer  "order_id",    limit: 4
    t.integer  "session_id",  limit: 4
    t.integer  "category_id", limit: 4
    t.integer  "amount",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carnival_sessions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "term"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carnival_sessions_categories", id: false, force: :cascade do |t|
    t.integer "session_id",  limit: 4
    t.integer "category_id", limit: 4
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.string   "training_group_ids",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",                    limit: 255
    t.text     "description",             limit: 65535
    t.string   "color",                   limit: 255
    t.integer  "theme_id",                limit: 4
    t.integer  "area_id",                 limit: 4
    t.boolean  "feature_training_groups",               default: true
    t.boolean  "feature_trainers",                      default: true
    t.boolean  "feature_messages",                      default: true
    t.boolean  "feature_galleries",                     default: true
    t.boolean  "feature_documents",                     default: true
    t.boolean  "feature_events",                        default: true
    t.string   "term_game",               limit: 255
    t.string   "term_games",              limit: 255
    t.string   "term_training_group",     limit: 255,   default: "Gruppe"
    t.string   "term_training_groups",    limit: 255,   default: "Gruppen"
    t.string   "term_competition",        limit: 255,   default: "Veranstaltung"
    t.string   "term_competitions",       limit: 255,   default: "Veranstaltungen"
    t.string   "term_trainer",            limit: 255,   default: "Betreuer"
    t.string   "term_trainers",           limit: 255,   default: "Betreuer"
    t.string   "term_athlet",             limit: 255,   default: "Teilnehmer"
    t.string   "term_athlets",            limit: 255,   default: "Teilnehmer"
    t.string   "term_training_unit",      limit: 255,   default: "Termin"
    t.string   "term_training_units",     limit: 255,   default: "Termine"
  end

  add_index "departments", ["slug"], name: "index_departments_on_slug", unique: true, using: :btree

  create_table "departments_flyers", id: false, force: :cascade do |t|
    t.integer  "department_id", limit: 4
    t.integer  "document_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments_users", id: false, force: :cascade do |t|
    t.integer  "department_id", limit: 4
    t.integer  "user_id",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "file",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "attachable_id",   limit: 4
    t.string   "attachable_type", limit: 255
    t.integer  "department_id",   limit: 4
  end

  add_index "documents", ["attachable_id", "attachable_type"], name: "index_documents_on_attachable_id_and_attachable_type", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.date     "term"
    t.text     "description",   limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_id", limit: 4
    t.string   "url",           limit: 255
  end

  create_table "extern_links", force: :cascade do |t|
    t.string   "url",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "galleries", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "preview_image_id", limit: 4
    t.integer  "department_id",    limit: 4
    t.date     "custom_date"
  end

  create_table "home_cycle_slides", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.string   "url",         limit: 255
    t.integer  "position",    limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "file",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "attachable_id",   limit: 4
    t.string   "attachable_type", limit: 255
    t.string   "type",            limit: 255
    t.integer  "width",           limit: 4
    t.integer  "height",          limit: 4
    t.float    "file_crop_x",     limit: 24
    t.float    "file_crop_y",     limit: 24
    t.float    "file_crop_w",     limit: 24
    t.float    "file_crop_h",     limit: 24
  end

  add_index "images", ["attachable_id", "attachable_type"], name: "index_images_on_attachable_id_and_attachable_type", using: :btree

  create_table "links", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "parent_id",     limit: 4
    t.integer  "lft",           limit: 4
    t.integer  "rgt",           limit: 4
    t.integer  "depth",         limit: 4
    t.integer  "department_id", limit: 4
    t.integer  "linkable_id",   limit: 4
    t.string   "linkable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                    default: true
    t.integer  "theme_id",      limit: 4
  end

  add_index "links", ["linkable_id", "linkable_type"], name: "index_links_on_linkable_id_and_linkable_type", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address",     limit: 255
    t.float    "latitude",    limit: 24
    t.float    "longitude",   limit: 24
    t.boolean  "gmaps"
    t.text     "description", limit: 65535
  end

  create_table "media_links", force: :cascade do |t|
    t.string   "controller_id", limit: 255
    t.integer  "instance_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "action_id",     limit: 255
  end

  create_table "messages", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.text     "content",       limit: 65535
    t.string   "department_id", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "abstract",      limit: 65535
    t.date     "custom_date"
    t.date     "visible_from"
    t.date     "visible_to"
    t.boolean  "published"
  end

  create_table "pages", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sidebar",                  default: false
    t.string   "slug",       limit: 255
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree

  create_table "placeholders", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quick_links", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "url",           limit: 255
    t.integer  "department_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                    default: true
    t.integer  "position",      limit: 4
  end

  create_table "references", force: :cascade do |t|
    t.integer  "reference_to_id",     limit: 4
    t.string   "reference_to_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reference_from_id",   limit: 4
    t.string   "reference_from_type", limit: 255
  end

  add_index "references", ["reference_from_id", "reference_from_type"], name: "index_references_on_reference_from_id_and_reference_from_type", using: :btree
  add_index "references", ["reference_to_id", "reference_to_type"], name: "index_references_on_reference_to_id_and_reference_to_type", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "short_routes", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "url",         limit: 255
    t.integer  "http_status", limit: 4,   default: 301
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "short_routes", ["name"], name: "index_short_routes_on_name", using: :btree

  create_table "themes", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.string   "color",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trainers", force: :cascade do |t|
    t.string   "first_name",  limit: 255
    t.string   "last_name",   limit: 255
    t.date     "birthday"
    t.string   "residence",   limit: 255
    t.string   "phone",       limit: 255
    t.string   "email",       limit: 255
    t.text     "profession",  limit: 65535
    t.text     "education",   limit: 65535
    t.text     "disciplines", limit: 65535
    t.text     "activities",  limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",        limit: 255
  end

  add_index "trainers", ["slug"], name: "index_trainers_on_slug", unique: true, using: :btree

  create_table "trainers_training_groups", id: false, force: :cascade do |t|
    t.integer "trainer_id",        limit: 4
    t.integer "training_group_id", limit: 4
  end

  create_table "training_groups", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.text     "description",   limit: 65535
    t.integer  "department_id", limit: 4
    t.integer  "age_begin",     limit: 4
    t.integer  "age_end",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ancient"
  end

  create_table "training_units", force: :cascade do |t|
    t.integer  "week_day",           limit: 4
    t.time     "time_begin"
    t.time     "time_end"
    t.integer  "location_summer_id", limit: 4
    t.integer  "location_winter_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "training_group_id",  limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.integer  "trainer_id",             limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
