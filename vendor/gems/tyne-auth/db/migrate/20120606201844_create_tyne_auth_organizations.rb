class CreateTyneAuthOrganizations < ActiveRecord::Migration
  def change
    create_table :tyne_auth_organizations do |t|
      t.string :name

      t.timestamps
    end
  end
end
