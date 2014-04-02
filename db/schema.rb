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

ActiveRecord::Schema.define(version: 20140325033413) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "codes", force: true do |t|
    t.integer  "set_id"
    t.string   "code"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "codes", ["set_id"], name: "index_codes_on_set_id", using: :btree

  create_table "courses", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "schedule"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dogs", force: true do |t|
    t.string   "name"
    t.string   "breed"
    t.string   "colour"
    t.date     "born_on"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dogs", ["person_id"], name: "index_dogs_on_person_id", using: :btree

  create_table "enrollments", force: true do |t|
    t.integer  "person_id"
    t.integer  "course_id"
    t.integer  "status_id"
    t.date     "enrolled_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enrollments", ["course_id"], name: "index_enrollments_on_course_id", using: :btree
  add_index "enrollments", ["person_id"], name: "index_enrollments_on_person_id", using: :btree
  add_index "enrollments", ["status_id"], name: "index_enrollments_on_status_id", using: :btree

  create_table "lessons", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "handout"
    t.datetime "lesson_at"
    t.integer  "course_id"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lessons", ["course_id"], name: "index_lessons_on_course_id", using: :btree
  add_index "lessons", ["status_id"], name: "index_lessons_on_status_id", using: :btree

  create_table "notes", force: true do |t|
    t.integer  "dog_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["dog_id"], name: "index_notes_on_dog_id", using: :btree

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "address"
    t.string   "city"
    t.string   "postal"
    t.string   "phone_home"
    t.string   "phone_cell"
    t.string   "phone_work"
    t.integer  "authority"
    t.date     "born_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "testimonials", force: true do |t|
    t.string   "from"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
