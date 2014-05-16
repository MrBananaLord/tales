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

ActiveRecord::Schema.define(version: 20140516081442) do

  create_table "choices", force: true do |t|
    t.text     "content"
    t.integer  "parent_paragraph_id"
    t.integer  "child_paragraph_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "choices", ["child_paragraph_id"], name: "index_choices_on_child_paragraph_id"
  add_index "choices", ["parent_paragraph_id"], name: "index_choices_on_parent_paragraph_id"

  create_table "games", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "published_at"
    t.integer  "owner_id"
    t.integer  "first_paragraph_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["first_paragraph_id"], name: "index_games_on_first_paragraph_id"
  add_index "games", ["owner_id"], name: "index_games_on_owner_id"

  create_table "paragraphs", force: true do |t|
    t.text     "content"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "paragraphs", ["game_id"], name: "index_paragraphs_on_game_id"

  create_table "users", force: true do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider_type"
    t.string   "provider_id"
    t.string   "username"
    t.string   "avatar"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
