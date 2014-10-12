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

ActiveRecord::Schema.define(version: 20140930222130) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "colour"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "parent_comment_id"
    t.integer  "user_id"
    t.text     "body"
    t.integer  "comments_count",          default: 0,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
  end

  add_index "comments", ["cached_votes_down"], name: "index_comments_on_cached_votes_down", using: :btree
  add_index "comments", ["cached_votes_score"], name: "index_comments_on_cached_votes_score", using: :btree
  add_index "comments", ["cached_votes_total"], name: "index_comments_on_cached_votes_total", using: :btree
  add_index "comments", ["cached_votes_up"], name: "index_comments_on_cached_votes_up", using: :btree
  add_index "comments", ["cached_weighted_average"], name: "index_comments_on_cached_weighted_average", using: :btree
  add_index "comments", ["cached_weighted_score"], name: "index_comments_on_cached_weighted_score", using: :btree
  add_index "comments", ["cached_weighted_total"], name: "index_comments_on_cached_weighted_total", using: :btree
  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["parent_comment_id"], name: "index_comments_on_parent_comment_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "evidence_items", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "submitter_id"
    t.integer  "policy_id"
    t.boolean  "accepted"
    t.integer  "comments_count",          default: 0, null: false
    t.integer  "cached_votes_total",      default: 0, null: false
    t.integer  "cached_votes_score",      default: 0, null: false
    t.integer  "cached_votes_up",         default: 0, null: false
    t.integer  "cached_votes_down",       default: 0, null: false
    t.integer  "cached_weighted_score",   default: 0, null: false
    t.integer  "cached_weighted_total",   default: 0, null: false
    t.integer  "cached_weighted_average", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "evidence_items", ["policy_id"], name: "index_evidence_items_on_policy_id", using: :btree
  add_index "evidence_items", ["submitter_id"], name: "index_evidence_items_on_submitter_id", using: :btree

  create_table "ip_logs", force: true do |t|
    t.integer  "user_id"
    t.string   "ip"
    t.datetime "last_seen"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ip_logs", ["ip"], name: "index_ip_logs_on_ip", using: :btree
  add_index "ip_logs", ["last_seen"], name: "index_ip_logs_on_last_seen", using: :btree
  add_index "ip_logs", ["user_id", "ip"], name: "index_ip_logs_on_user_id_and_ip", unique: true, using: :btree
  add_index "ip_logs", ["user_id"], name: "index_ip_logs_on_user_id", using: :btree

  create_table "oauth_access_grants", force: true do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: true do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: true do |t|
    t.string   "name",         null: false
    t.string   "uid",          null: false
    t.string   "secret",       null: false
    t.text     "redirect_uri", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "policies", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "submitter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.integer  "category_id"
    t.integer  "comments_count",          default: 0,            null: false
    t.string   "state",                   default: "suggestion", null: false
    t.string   "promotion_state",         default: "waiting",    null: false
    t.integer  "previous_version_id"
  end

  add_index "policies", ["cached_votes_down"], name: "index_policies_on_cached_votes_down", using: :btree
  add_index "policies", ["cached_votes_score"], name: "index_policies_on_cached_votes_score", using: :btree
  add_index "policies", ["cached_votes_total"], name: "index_policies_on_cached_votes_total", using: :btree
  add_index "policies", ["cached_votes_up"], name: "index_policies_on_cached_votes_up", using: :btree
  add_index "policies", ["cached_weighted_average"], name: "index_policies_on_cached_weighted_average", using: :btree
  add_index "policies", ["cached_weighted_score"], name: "index_policies_on_cached_weighted_score", using: :btree
  add_index "policies", ["cached_weighted_total"], name: "index_policies_on_cached_weighted_total", using: :btree
  add_index "policies", ["category_id"], name: "index_policies_on_category_id", using: :btree
  add_index "policies", ["previous_version_id"], name: "index_policies_on_previous_version_id", using: :btree
  add_index "policies", ["promotion_state"], name: "index_policies_on_promotion_state", using: :btree
  add_index "policies", ["state"], name: "index_policies_on_state", using: :btree
  add_index "policies", ["submitter_id"], name: "index_policies_on_submitter_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.string   "username",                             default: "",     null: false
    t.string   "email",                                                 null: false
    t.string   "encrypted_password",       limit: 128,                  null: false
    t.string   "confirmation_token",       limit: 128
    t.string   "remember_token",           limit: 128,                  null: false
    t.string   "email_confirmation_token"
    t.datetime "email_confirmed_on"
    t.string   "role",                                 default: "user", null: false
    t.string   "last_ip"
    t.datetime "banned_until"
    t.datetime "deleted_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["email_confirmation_token"], name: "index_users_on_email_confirmation_token", using: :btree
  add_index "users", ["email_confirmed_on"], name: "index_users_on_email_confirmed_on", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
