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

ActiveRecord::Schema.define(version: 20171018000403) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "question_id", null: false
    t.text "answer", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "answer_id", null: false
    t.integer "parent_id"
    t.text "comment", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_comments_on_answer_id"
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "question_topics", id: false, force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "topic_id", null: false
    t.index ["question_id", "topic_id"], name: "index_question_topics_on_question_id_and_topic_id", unique: true
  end

  create_table "questions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "question", limit: 250, null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "topic_users", id: false, force: :cascade do |t|
    t.bigint "topic_id", null: false
    t.bigint "user_id", null: false
    t.index ["topic_id", "user_id"], name: "index_topic_users_on_topic_id_and_user_id", unique: true
  end

  create_table "topics", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "content_id", null: false
    t.string "content_type", null: false
    t.integer "vote_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_type", "content_id"], name: "index_votes_on_content_type_and_content_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "comments", "answers"
  add_foreign_key "comments", "comments", column: "parent_id"
  add_foreign_key "comments", "users"
  add_foreign_key "questions", "users"
  add_foreign_key "votes", "users"
end
