class CreateDashboards < ActiveRecord::Migration
  def change
    create_table :dashboards do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
    add_index :dashboards, :user_id
  end
end
