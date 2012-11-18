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

ActiveRecord::Schema.define(:version => 20121118142434) do

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

  create_table "tyne_core_dashboards", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tyne_core_dashboards", ["user_id"], :name => "index_tyne_core_dashboards_on_user_id"

  create_table "tyne_core_issue_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tyne_core_issues", :force => true do |t|
    t.string   "summary"
    t.text     "description"
    t.integer  "reported_by_id"
    t.integer  "project_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "issue_type_id"
    t.string   "state",          :default => "open"
  end

  add_index "tyne_core_issues", ["issue_type_id"], :name => "index_tyne_core_issues_on_issue_type_id"
  add_index "tyne_core_issues", ["project_id"], :name => "index_tyne_core_issues_on_project_id"
  add_index "tyne_core_issues", ["reported_by_id"], :name => "index_tyne_core_issues_on_reported_by_id"

  create_table "tyne_core_projects", :force => true do |t|
    t.string   "name"
    t.string   "key"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
  end

  add_index "tyne_core_projects", ["key"], :name => "index_tyne_core_projects_on_key"
  add_index "tyne_core_projects", ["user_id"], :name => "index_tyne_core_projects_on_user_id"

end
