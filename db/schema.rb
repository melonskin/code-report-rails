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

ActiveRecord::Schema.define(version: 20180128070254) do

  create_table "users", force: :cascade do |t|
    t.string "login"
    t.string "avatar_url"
    t.string "html_url"
    t.string "name"
    t.string "public_repos"
    t.string "followers"
    t.string "following"
    t.string "createat"
    t.string "updateat"
    t.string "lang1"
    t.string "lang2"
    t.string "lang3"
    t.string "lang1num"
    t.string "lang2num"
    t.string "lang3num"
    t.string "commits_num"
    t.string "late_commit_repo"
    t.string "late_commit_time"
    t.string "old_repo"
    t.string "old_repo_time"
    t.string "most_commits_time"
    t.string "most_commits_num"
    t.string "big_repo"
    t.string "big_repo_commits_num"
  end

end
