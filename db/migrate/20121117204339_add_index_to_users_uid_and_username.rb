class AddIndexToUsersUidAndUsername < ActiveRecord::Migration
  def change
    add_index :users, :uid
    add_index :users, :username
  end
end
