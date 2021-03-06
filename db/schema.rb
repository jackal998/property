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

ActiveRecord::Schema.define(version: 20161204130409) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "emotion_tag"
    t.string   "paragraph"
    t.integer  "obj_id"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "title"
    t.boolean  "ispublic",    default: true
    t.index ["obj_id"], name: "index_comments_on_obj_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "obj_categoryships", force: :cascade do |t|
    t.integer  "obj_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "obj_tagships", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "obj_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "objs", force: :cascade do |t|
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.string   "name"
    t.string   "serial"
    t.date     "datebought"
    t.date     "dateretire"
    t.integer  "value",              limit: 8
    t.string   "snumber1"
    t.string   "snumber2"
    t.text     "description"
    t.boolean  "ispublic"
    t.integer  "user_id"
    t.string   "custodian"
    t.integer  "comments_count",               default: 0
    t.integer  "views_count",                  default: 0
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "schedule_public",              default: '1900-01-01 00:00:00'
    t.integer  "access_authority",             default: 4
    t.index ["user_id"], name: "index_objs_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_collectionships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "obj_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_likeships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "obj_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_subscribeships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "obj_id"
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
    t.string   "nickname"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "role"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "fb_uid"
    t.string   "fb_token"
    t.string   "fb_raw_data"
    t.string   "fb_name"
    t.string   "fb_avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["fb_uid"], name: "index_users_on_fb_uid"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "userships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
