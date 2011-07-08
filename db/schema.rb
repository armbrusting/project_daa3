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

ActiveRecord::Schema.define(:version => 20110708213606) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["name"], :name => "index_companies_on_name", :unique => true

  create_table "folders", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "folders", ["name"], :name => "index_folders_on_name"

  create_table "styles", :force => true do |t|
    t.string   "number"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "description"
    t.string   "department"
    t.string   "classification"
    t.string   "season"
    t.boolean  "printed"
    t.boolean  "embellished"
    t.integer  "moq"
  end

  add_index "styles", ["classification"], :name => "index_styles_on_classification"
  add_index "styles", ["department"], :name => "index_styles_on_department"
  add_index "styles", ["embellished"], :name => "index_styles_on_embellished"
  add_index "styles", ["moq"], :name => "index_styles_on_moq"
  add_index "styles", ["number"], :name => "index_styles_on_number"
  add_index "styles", ["printed"], :name => "index_styles_on_printed"
  add_index "styles", ["season"], :name => "index_styles_on_season"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "admin",               :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name"

end
