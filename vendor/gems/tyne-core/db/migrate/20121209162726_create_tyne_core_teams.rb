class CreateTyneCoreTeams < ActiveRecord::Migration
  def change
    create_table :tyne_core_teams do |t|
      t.string :name
      t.integer :project_id
      t.boolean :admin_privileges
    end

    add_index :tyne_core_teams, :project_id
  end
end
