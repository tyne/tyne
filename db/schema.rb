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

ActiveRecord::Schema.define(:version => 20130419210703) do

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         :default => 0
    t.string   "comment"
    t.string   "remote_address"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], :name => "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "comments", :force => true do |t|
    t.text     "message"
    t.integer  "issue_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["issue_id"], :name => "index_comments_on_issue_id"

  create_table "dashboards", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "dashboards", ["user_id"], :name => "index_dashboards_on_user_id"

  create_table "issue_labels", :force => true do |t|
    t.integer "issue_id"
    t.integer "label_id"
  end

  create_table "issue_priorities", :force => true do |t|
    t.string   "name"
    t.integer  "number"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "issue_priorities", ["number"], :name => "index_issue_priorities_on_number"

  create_table "issue_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "issues", :force => true do |t|
    t.string   "summary"
    t.text     "description"
    t.integer  "reported_by_id"
    t.integer  "project_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "issue_type_id"
    t.string   "state",             :default => "open"
    t.integer  "number"
    t.integer  "issue_priority_id"
    t.integer  "assigned_to_id"
    t.integer  "sprint_id"
    t.integer  "position"
    t.integer  "sprint_position"
    t.decimal  "estimate"
  end

  add_index "issues", ["issue_priority_id"], :name => "index_issues_on_issue_priority_id"
  add_index "issues", ["issue_type_id"], :name => "index_issues_on_issue_type_id"
  add_index "issues", ["number"], :name => "index_issues_on_number"
  add_index "issues", ["project_id"], :name => "index_issues_on_project_id"
  add_index "issues", ["reported_by_id"], :name => "index_issues_on_reported_by_id"
  add_index "issues", ["sprint_id"], :name => "index_issues_on_sprint_id"

  create_table "labels", :force => true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "colour"
  end

  create_table "organization_memberships", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "organization_memberships", ["organization_id", "user_id"], :name => "organization_id_user_id", :unique => true
  add_index "organization_memberships", ["organization_id"], :name => "index_organization_memberships_on_organization_id"
  add_index "organization_memberships", ["user_id"], :name => "index_organization_memberships_on_user_id"

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "key"
    t.text     "description"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "user_id"
    t.boolean  "privacy",     :default => false
  end

  add_index "projects", ["key"], :name => "index_projects_on_key"
  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"

  create_table "sprint_activities", :force => true do |t|
    t.integer  "sprint_id"
    t.integer  "issue_id"
    t.string   "type_of_change"
    t.decimal  "scope_change"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "sprint_activities", ["issue_id"], :name => "index_sprint_activities_on_issue_id"
  add_index "sprint_activities", ["sprint_id"], :name => "index_sprint_activities_on_sprint_id"

  create_table "sprints", :force => true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "project_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "active",     :default => false
    t.date     "finished"
  end

  create_table "team_members", :force => true do |t|
    t.integer "user_id"
    t.integer "team_id"
  end

  add_index "team_members", ["team_id"], :name => "index_team_members_on_team_id"
  add_index "team_members", ["user_id"], :name => "index_team_members_on_user_id"

  create_table "teams", :force => true do |t|
    t.string  "name"
    t.integer "project_id"
    t.boolean "admin_privileges"
  end

  add_index "teams", ["project_id"], :name => "index_teams_on_project_id"

  create_table "users", :force => true do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "username"
    t.string   "email"
    t.string   "token"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "gravatar_id"
    t.string   "notification_email"
  end

  add_index "users", ["uid"], :name => "index_users_on_uid"
  add_index "users", ["username"], :name => "index_users_on_username"

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.string   "votable_type"
    t.integer  "votable_id"
    t.integer  "weight"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"
  add_index "votes", ["votable_type", "votable_id"], :name => "index_votes_on_votable_type_and_votable_id"

end
