# This migration comes from tyne_core (originally 20121109210432)
class CreateTyneCoreDashboards < ActiveRecord::Migration
  def up
    create_table :tyne_core_dashboards do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
    add_index :tyne_core_dashboards, :user_id

    # Create a dashboard for all existing users
    TyneAuth::User.all.each do |user|
      user.dashboards.create!(:name => "Default")
    end
  end
end
