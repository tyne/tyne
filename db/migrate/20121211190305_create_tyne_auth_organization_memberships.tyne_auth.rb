# This migration comes from tyne_auth (originally 20121210190837)
class CreateTyneAuthOrganizationMemberships < ActiveRecord::Migration
  def change
    create_table :tyne_auth_organization_memberships do |t|
      t.references :organization
      t.references :user

      t.timestamps
    end

    add_index :tyne_auth_organization_memberships, :organization_id
    add_index :tyne_auth_organization_memberships, :user_id
    add_index :tyne_auth_organization_memberships, [:organization_id, :user_id], :unique => true, :name => :organization_id_user_id
  end
end
