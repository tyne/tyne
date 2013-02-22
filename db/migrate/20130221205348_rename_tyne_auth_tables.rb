class RenameTyneAuthTables < ActiveRecord::Migration
  def change
    rename_table :tyne_auth_users, :users
    rename_table :tyne_auth_organizations, :organizations
    rename_table :tyne_auth_organization_memberships, :organization_memberships

    Audited::Adapters::ActiveRecord::Audit.update_all(:user_type => "User")
  end
end
