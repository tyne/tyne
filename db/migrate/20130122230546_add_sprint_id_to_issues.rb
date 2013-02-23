class AddSprintIdToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :sprint_id, :integer

    add_index :issues, :sprint_id
  end
end
