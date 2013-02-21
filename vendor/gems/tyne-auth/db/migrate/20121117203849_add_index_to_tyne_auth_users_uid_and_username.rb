class AddIndexToTyneAuthUsersUidAndUsername < ActiveRecord::Migration
  def change
    add_index :tyne_auth_users, :uid
    add_index :tyne_auth_users, :username
  end
end
