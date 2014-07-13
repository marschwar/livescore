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

ActiveRecord::Schema.define(version: 20140713134046) do

  create_table "comments", force: true do |t|
    t.integer  "game_id",    null: false
    t.integer  "user_id",    null: false
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["game_id"], name: "index_comments_on_game_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "games", force: true do |t|
    t.integer  "home_team_id",                                    null: false
    t.integer  "away_team_id",                                    null: false
    t.string   "location"
    t.integer  "home_quarter_1",            default: 0,           null: false
    t.integer  "home_quarter_2",            default: 0,           null: false
    t.integer  "home_quarter_3",            default: 0,           null: false
    t.integer  "home_quarter_4",            default: 0,           null: false
    t.integer  "away_quarter_1",            default: 0,           null: false
    t.integer  "away_quarter_2",            default: 0,           null: false
    t.integer  "away_quarter_3",            default: 0,           null: false
    t.integer  "away_quarter_4",            default: 0,           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "period",                    default: "unstarted", null: false
    t.date     "game_day",                                        null: false
    t.string   "game_time"
    t.string   "possession",     limit: 10
    t.integer  "user_id",                                         null: false
  end

  create_table "notes", force: true do |t|
    t.integer  "game_id",    null: false
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supporters", force: true do |t|
    t.integer  "game_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "supporters", ["game_id"], name: "index_supporters_on_game_id", using: :btree
  add_index "supporters", ["user_id"], name: "index_supporters_on_user_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "name"
    t.text     "encoded_image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "common_name",                    null: false
    t.string   "social_id"
    t.string   "email"
    t.string   "role",          default: "user", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "encoded_image"
    t.string   "image_type"
  end

end
