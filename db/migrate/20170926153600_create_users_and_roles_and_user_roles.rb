class CreateUsersAndRolesAndUserRoles < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string :username, :null => true
      t.string :email, :null => false
      t.string :password
      t.timestamps
    end
    create_table :roles do |t|
      t.string :role_name, :null => false
      t.timestamps
    end

    create_table :user_roles do |t|
      t.integer :user_id, :null => false
      t.integer :role_id, :null => false
      t.timestamps
    end
    add_index :user_roles, :user_id
    add_index :user_roles, :role_id
  end
end