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

ActiveRecord::Schema.define(version: 20130925205707) do

  create_table "courses", force: true do |t|
    t.string   "name"
    t.text     "description"
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

  create_table "notes", force: true do |t|
    t.integer  "dog_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "email"
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

end
