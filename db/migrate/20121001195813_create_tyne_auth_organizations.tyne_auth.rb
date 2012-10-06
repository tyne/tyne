# This migration comes from tyne_auth (originally 20120606201844)
class CreateTyneAuthOrganizations < ActiveRecord::Migration
  def change
    create_table :tyne_auth_organizations do |t|
      t.string :name

      t.timestamps
    end
  end
end
