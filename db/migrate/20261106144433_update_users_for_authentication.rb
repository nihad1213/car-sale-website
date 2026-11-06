class UpdateUsersForAuthentication < ActiveRecord::Migration[8.1]
  def change
    rename_column :users, :firstname, :first_name
    rename_column :users, :lastname, :last_name
    add_column :users, :password_digest, :string
  end
end
