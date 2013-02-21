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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121210190837) do

  create_table "tyne_auth_organization_memberships", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "tyne_auth_organization_memberships", ["organization_id", "user_id"], :name => "organization_id_user_id", :unique => true
  add_index "tyne_auth_organization_memberships", ["organization_id"], :name => "index_tyne_auth_organization_memberships_on_organization_id"
  add_index "tyne_auth_organization_memberships", ["user_id"], :name => "index_tyne_auth_organization_memberships_on_user_id"

  create_table "tyne_auth_organizations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tyne_auth_users", :force => true do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "username"
    t.string   "email"
    t.string   "token"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "gravatar_id"
  end

  add_index "tyne_auth_users", ["uid"], :name => "index_tyne_auth_users_on_uid"
  add_index "tyne_auth_users", ["username"], :name => "index_tyne_auth_users_on_username"

end
