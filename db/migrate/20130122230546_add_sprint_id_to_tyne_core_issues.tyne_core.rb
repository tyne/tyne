# This migration comes from tyne_core (originally 20130122230424)
class AddSprintIdToTyneCoreIssues < ActiveRecord::Migration
  def change
    add_column :tyne_core_issues, :sprint_id, :integer

    add_index :tyne_core_issues, :sprint_id
  end
end
