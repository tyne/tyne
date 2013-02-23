class CreateOrganizationMemberships < ActiveRecord::Migration
  def change
    create_table :organization_memberships do |t|
      t.references :organization
      t.references :user

      t.timestamps
    end

    add_index :organization_memberships, :organization_id
    add_index :organization_memberships, :user_id
    add_index :organization_memberships, [:organization_id, :user_id], :unique => true, :name => :organization_id_user_id
  end
end
