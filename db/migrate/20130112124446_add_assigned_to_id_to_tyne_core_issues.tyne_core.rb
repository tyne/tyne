# This migration comes from tyne_core (originally 20130112124111)
class AddAssignedToIdToTyneCoreIssues < ActiveRecord::Migration
  def change
    add_column :tyne_core_issues, :assigned_to_id, :integer
  end
end
