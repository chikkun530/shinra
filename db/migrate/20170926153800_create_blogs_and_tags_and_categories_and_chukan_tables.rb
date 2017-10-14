class CreateBlogsAndTagsAndCategoriesAndChukanTables < ActiveRecord::Migration[4.2]
  def change
    create_table :blogs do |t|
      t.integer :user_id, :null => false
      t.string :title, :null => false
      t.text :content, :null => false
      t.datetime :issue_date
      t.timestamps
    end
    create_table :tags do |t|
      t.string :tag_name, :null => false
      t.timestamps
    end

    create_table :categories do |t|
      t.string :category_name, :null => false
      t.timestamps
    end

    create_table :blog_tags do |t|
      t.integer :blog_id, :null => false
      t.integer :tag_id, :null => false
      t.timestamps
    end
    create_table :blog_categories do |t|
      t.integer :blog_id, :null => false
      t.integer :category_id, :null => false
      t.timestamps
    end

    add_index :blog_categories, :blog_id
    add_index :blog_categories, :category_id

    add_index :blog_tags, :blog_id
    add_index :blog_tags, :tag_id
  end
end