class CreateTyneCoreIssues < ActiveRecord::Migration
  def change
    create_table :tyne_core_issues do |t|
      t.string :summary
      t.text :description
      t.integer :reported_by_id
      t.integer :project_id

      t.timestamps
    end
    add_index :tyne_core_issues, :reported_by_id
    add_index :tyne_core_issues, :project_id
  end
end
