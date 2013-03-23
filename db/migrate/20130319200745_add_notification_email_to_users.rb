class AddNotificationEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notification_email, :string
  end
end
