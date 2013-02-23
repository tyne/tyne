class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :summary
      t.text :description
      t.integer :reported_by_id
      t.integer :project_id

      t.timestamps
    end
    add_index :issues, :reported_by_id
    add_index :issues, :project_id
  end
end
