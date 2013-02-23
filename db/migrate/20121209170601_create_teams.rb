class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :project_id
      t.boolean :admin_privileges
    end

    add_index :teams, :project_id
  end
end
