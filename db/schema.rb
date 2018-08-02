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

ActiveRecord::Schema.define(version: 2018_08_01_153755) do

  create_table "challenge_assignments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "challenge_id"
    t.bigint "user_id"
    t.integer "signup_id"
    t.integer "assignment_id"
    t.datetime "sent_at"
    t.integer "work_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_challenge_assignments_on_assignment_id"
    t.index ["challenge_id"], name: "index_challenge_assignments_on_challenge_id"
    t.index ["signup_id"], name: "index_challenge_assignments_on_signup_id"
    t.index ["user_id"], name: "index_challenge_assignments_on_user_id"
  end

  create_table "challenge_mods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "challenge_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id", "user_id"], name: "index_challenge_mods_on_challenge_id_and_user_id", unique: true
    t.index ["challenge_id"], name: "index_challenge_mods_on_challenge_id"
    t.index ["user_id"], name: "index_challenge_mods_on_user_id"
  end

  create_table "challenge_signups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "challenge_id"
    t.bigint "user_id"
    t.boolean "approved", default: false, null: false
    t.boolean "complete", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_challenge_signups_on_challenge_id"
    t.index ["user_id"], name: "index_challenge_signups_on_user_id"
  end

  create_table "challenges", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "type", null: false
    t.bigint "user_id"
    t.string "name", default: "", null: false
    t.text "description"
    t.text "rules"
    t.boolean "active", default: true, null: false
    t.integer "collection_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deadline"
    t.index ["collection_id"], name: "index_challenges_on_collection_id"
    t.index ["type"], name: "index_challenges_on_type"
    t.index ["user_id"], name: "index_challenges_on_user_id"
  end

  create_table "collection_taggings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "collection_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id", "tag_id"], name: "index_collection_taggings_on_collection_id_and_tag_id", unique: true
    t.index ["collection_id"], name: "index_collection_taggings_on_collection_id"
    t.index ["tag_id"], name: "index_collection_taggings_on_tag_id"
  end

  create_table "collections", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "potential_matches", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "challenge_signup_id"
    t.bigint "challenge_id"
    t.integer "total_matches"
    t.text "matches"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_potential_matches_on_challenge_id"
    t.index ["challenge_signup_id"], name: "index_potential_matches_on_challenge_signup_id"
  end

  create_table "prompt_taggings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "prompt_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prompt_id", "tag_id"], name: "index_prompt_taggings_on_prompt_id_and_tag_id", unique: true
    t.index ["prompt_id"], name: "index_prompt_taggings_on_prompt_id"
    t.index ["tag_id"], name: "index_prompt_taggings_on_tag_id"
  end

  create_table "prompts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "assignee_id"
    t.text "body"
    t.integer "challenge_id"
    t.boolean "fulfilled", default: false, null: false
    t.boolean "offer", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "works_count", default: 0, null: false
    t.integer "signup_id"
    t.index ["assignee_id"], name: "index_prompts_on_assignee_id"
    t.index ["challenge_id", "assignee_id"], name: "index_prompts_on_challenge_id_and_assignee_id"
    t.index ["challenge_id", "user_id"], name: "index_prompts_on_challenge_id_and_user_id"
    t.index ["signup_id"], name: "index_prompts_on_signup_id"
    t.index ["user_id"], name: "index_prompts_on_user_id"
  end

  create_table "set_taggings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tag_set_id", null: false
    t.bigint "tag_id", null: false
    t.boolean "accepted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_set_taggings_on_tag_id"
    t.index ["tag_set_id", "tag_id"], name: "index_set_taggings_on_tag_set_id_and_tag_id", unique: true
    t.index ["tag_set_id"], name: "index_set_taggings_on_tag_set_id"
    t.index ["user_id"], name: "index_set_taggings_on_user_id"
  end

  create_table "tag_sets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "challenge_id"
    t.boolean "accepting_noms", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["challenge_id"], name: "index_tag_sets_on_challenge_id"
    t.index ["user_id"], name: "index_tag_sets_on_user_id"
  end

  create_table "tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "type", default: "", null: false
    t.boolean "canonical", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type", "name"], name: "index_tags_on_type_and_name", unique: true
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "login", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["login"], name: "index_users_on_login", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "works", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.text "body"
    t.bigint "user_id"
    t.bigint "prompt_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prompt_id"], name: "index_works_on_prompt_id"
    t.index ["user_id"], name: "index_works_on_user_id"
  end

  add_foreign_key "challenge_signups", "challenges"
  add_foreign_key "challenge_signups", "users"
  add_foreign_key "potential_matches", "challenge_signups"
  add_foreign_key "potential_matches", "challenges"
  add_foreign_key "tag_sets", "users"
end
