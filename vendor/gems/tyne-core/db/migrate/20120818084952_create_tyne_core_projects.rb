class CreateTyneCoreProjects < ActiveRecord::Migration
  def change
    create_table :tyne_core_projects do |t|
      t.string :name
      t.string :key
      t.text :description

      t.timestamps
    end
    add_index :tyne_core_projects, :key
  end
end
