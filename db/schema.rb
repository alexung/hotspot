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

ActiveRecord::Schema.define(version: 20141112021317) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contributions", force: true do |t|
    t.integer "repository_file_id"
    t.integer "contributor_id"
  end

  create_table "contributors", force: true do |t|
    t.integer "repository_id"
    t.string  "email"
    t.string  "gravatar_url"
  end

  create_table "github_users", force: true do |t|
    t.integer "contributor_id"
    t.string  "username"
    t.string  "gh_avatar_url"
    t.string  "gh_repo_url"
  end

  create_table "notes", force: true do |t|
    t.integer  "repo_uid"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repositories", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "url"
    t.string   "repo_owner"
    t.integer  "repo_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repository_files", force: true do |t|
    t.integer  "repository_id"
    t.string   "github_url"
    t.string   "name"
    t.integer  "insertions"
    t.integer  "deletions"
    t.integer  "commits"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "github_username"
    t.string   "github_uid"
    t.string   "email"
    t.string   "avatar_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
