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

ActiveRecord::Schema.define(:version => 20130704194346) do

  create_table "choices", :force => true do |t|
    t.integer "question_id"
    t.string  "choice"
  end

  add_index "choices", ["question_id"], :name => "index_choices_on_question_id"

  create_table "polls", :force => true do |t|
    t.integer "user_id"
    t.string  "title"
    t.integer "team_id"
  end

  add_index "polls", ["team_id"], :name => "index_polls_on_team_id"
  add_index "polls", ["user_id"], :name => "index_polls_on_user_id"

  create_table "questions", :force => true do |t|
    t.text    "title"
    t.integer "poll_id"
  end

  add_index "questions", ["poll_id"], :name => "index_questions_on_poll_id"

  create_table "responses", :force => true do |t|
    t.integer "choice_id"
    t.integer "user_id"
  end

  add_index "responses", ["choice_id"], :name => "index_responses_on_choice_id"
  add_index "responses", ["user_id"], :name => "index_responses_on_user_id"

  create_table "teams", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string  "username"
    t.integer "team_id"
  end

  add_index "users", ["team_id"], :name => "index_users_on_team_id"

end
