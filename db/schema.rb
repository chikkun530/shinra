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

ActiveRecord::Schema.define(version: 20170926153800) do

  create_table "blog_categories", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "blog_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["blog_id"], name: "index_blog_categories_on_blog_id"
    t.index ["category_id"], name: "index_blog_categories_on_category_id"
  end

  create_table "blog_tags", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "blog_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["blog_id"], name: "index_blog_tags_on_blog_id"
    t.index ["tag_id"], name: "index_blog_tags_on_tag_id"
  end

  create_table "blogs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id", null: false
    t.string "title", null: false
    t.text "content", null: false
    t.datetime "issue_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "category_name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "role_name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "tag_name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "username"
    t.string "email", null: false
    t.string "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
