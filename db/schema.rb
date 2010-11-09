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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101105162639) do

  create_table "composers", :force => true do |t|
    t.string   "name"
    t.string   "century"
    t.string   "info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ragams", :force => true do |t|
    t.string   "name"
    t.string   "arohana"
    t.string   "avarohana"
    t.boolean  "major"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "song_compositions", :force => true do |t|
    t.integer  "song_type_id"
    t.integer  "song_content_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "song_content_infos", :force => true do |t|
    t.integer  "song_content_id"
    t.integer  "info_id"
    t.string   "info_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "song_content_types", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "song_contents", :force => true do |t|
    t.integer  "song_id"
    t.integer  "song_content_type_id"
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "song_types", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "songs", :force => true do |t|
    t.string   "name"
    t.integer  "song_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "composer_id"
    t.integer  "ragam_id"
    t.integer  "talam_id"
    t.string   "description"
  end

  create_table "talams", :force => true do |t|
    t.string   "name"
    t.string   "avartanam"
    t.integer  "laghu_length"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
