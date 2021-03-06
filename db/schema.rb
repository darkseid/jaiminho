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

ActiveRecord::Schema.define(version: 20141119170247) do

  create_table "email_requests", force: true do |t|
    t.string   "email_to"
    t.text     "data"
    t.integer  "status",            default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reply_to"
    t.string   "cc"
    t.string   "bcc"
    t.integer  "email_template_id",             null: false
  end

  add_index "email_requests", ["status", "email_template_id", "created_at"], name: "idx_st_email_t_created", using: :btree

  create_table "email_templates", force: true do |t|
    t.string   "name"
    t.text     "body"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
