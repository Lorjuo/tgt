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

ActiveRecord::Schema.define(version: 20140408132524) do

  create_table "announcements", force: true do |t|
    t.string   "name"
    t.text     "caption"
    t.string   "link"
    t.boolean  "active",       default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "visible_from"
    t.date     "visible_to"
  end

  create_table "carnival_categories", force: true do |t|
    t.string   "name"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carnival_orders", primary_key: "order_id", force: true do |t|
    t.integer  "person_id"
    t.string   "notice"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carnival_people", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street"
    t.string   "zip"
    t.string   "city"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carnival_reservations", force: true do |t|
    t.integer  "order_id"
    t.integer  "session_id"
    t.integer  "category_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carnival_sessions", force: true do |t|
    t.string   "name"
    t.datetime "term"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carnival_sessions_categories", id: false, force: true do |t|
    t.integer "session_id"
    t.integer "category_id"
  end

  create_table "departments", force: true do |t|
    t.string   "name"
    t.string   "training_group_ids"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.text     "description"
    t.string   "color"
  end

  add_index "departments", ["slug"], name: "index_departments_on_slug", unique: true, using: :btree

  create_table "departments_flyers", id: false, force: true do |t|
    t.integer  "department_id"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments_users", id: false, force: true do |t|
    t.integer  "department_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: true do |t|
    t.string   "name"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.integer  "department_id"
  end

  add_index "documents", ["attachable_id", "attachable_type"], name: "index_documents_on_attachable_id_and_attachable_type", using: :btree

  create_table "events", force: true do |t|
    t.string   "name"
    t.date     "term"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "galleries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "preview_image_id"
    t.integer  "department_id"
    t.date     "custom_date"
  end

  create_table "images", force: true do |t|
    t.string   "name"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "attachable_id"
    t.string   "attachable_type"
  end

  add_index "images", ["attachable_id", "attachable_type"], name: "index_images_on_attachable_id_and_attachable_type", using: :btree

  create_table "locations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.text     "description"
  end

  create_table "messages", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "abstract"
    t.date     "custom_date"
  end

  create_table "navigation_elements", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.integer  "department_id"
    t.string   "controller_id"
    t.string   "action_id"
    t.integer  "instance_id"
  end

  create_table "pages", force: true do |t|
    t.string   "name"
    t.integer  "department_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "references", force: true do |t|
    t.integer  "reference_to_id"
    t.string   "reference_to_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reference_from_id"
    t.string   "reference_from_type"
  end

  add_index "references", ["reference_from_id", "reference_from_type"], name: "index_references_on_reference_from_id_and_reference_from_type", using: :btree
  add_index "references", ["reference_to_id", "reference_to_type"], name: "index_references_on_reference_to_id_and_reference_to_type", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "trainers", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthday"
    t.string   "residence"
    t.string   "phone"
    t.string   "email"
    t.text     "profession"
    t.text     "education"
    t.text     "disciplines"
    t.text     "activities"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "trainers", ["slug"], name: "index_trainers_on_slug", unique: true, using: :btree

  create_table "trainers_training_groups", id: false, force: true do |t|
    t.integer "trainer_id"
    t.integer "training_group_id"
  end

  create_table "training_groups", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "department_id"
    t.integer  "age_begin"
    t.integer  "age_end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ancient"
  end

  create_table "training_units", force: true do |t|
    t.integer  "week_day"
    t.time     "time_begin"
    t.time     "time_end"
    t.integer  "location_summer_id"
    t.integer  "location_winter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "training_group_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "trainer_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
