# This migration comes from tyne_auth (originally 20120606185926)
class CreateTyneAuthUsers < ActiveRecord::Migration
  def change
    create_table :tyne_auth_users do |t|
      t.string :uid
      t.string :name
      t.string :username
      t.string :email
      t.string :token

      t.timestamps
    end
  end
end
