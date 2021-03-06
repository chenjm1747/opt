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

ActiveRecord::Schema.define(version: 20150519231518) do

  create_table "azufangs", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.text     "innertext"
    t.string   "xiaoqu"
    t.string   "title"
    t.integer  "area"
    t.integer  "minprice"
    t.string   "lianxiren"
    t.string   "phone"
    t.string   "tupian"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "money"
    t.string   "weixin"
    t.integer  "qq"
    t.integer  "shi"
    t.integer  "ting"
    t.integer  "wei"
    t.integer  "ceng"
    t.integer  "zongceng"
  end

  create_table "blogs", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "address"
    t.string   "email"
    t.string   "fax"
    t.text     "description"
    t.decimal  "level"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string   "filename"
    t.string   "content_type"
    t.binary   "file_contents"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "l1s", force: :cascade do |t|
    t.string   "a"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "user"
    t.string   "passwd58"
  end

  create_table "ls", force: :cascade do |t|
    t.string   "a"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "p2pcompanies", force: :cascade do |t|
    t.string   "c_name"
    t.string   "c_icon"
    t.string   "c_net_address"
    t.string   "c_phone"
    t.string   "c_address"
    t.string   "c_create_time"
    t.string   "c_persion"
    t.string   "c_province"
    t.string   "c_product_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "p2pproducts", force: :cascade do |t|
    t.string   "name"
    t.string   "company"
    t.string   "lowestAmount"
    t.string   "producttypelabel"
    t.string   "suppliernameshort"
    t.string   "supplierlogourl"
    t.string   "channelurl"
    t.string   "expectedprofitrate"
    t.string   "idea"
    t.string   "extrafields"
    t.string   "investfield"
    t.integer  "term"
    t.integer  "p_min_investment"
    t.integer  "earlyBack"
    t.integer  "earlytransfer"
    t.string   "p_title"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.text     "bio"
    t.date     "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "softnames", force: :cascade do |t|
    t.string   "name"
    t.integer  "huajun_id"
    t.integer  "duote_id"
    t.integer  "crsky_id"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.string   "username"
    t.string   "passwd58"
    t.string   "money"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "welcomes", force: :cascade do |t|
    t.string   "a"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "yonghus", force: :cascade do |t|
    t.string   "xingming"
    t.string   "gongsimingcheng"
    t.string   "shouji"
    t.integer  "qq"
    t.integer  "quhao"
    t.integer  "gongsidianhua"
    t.string   "ip"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
