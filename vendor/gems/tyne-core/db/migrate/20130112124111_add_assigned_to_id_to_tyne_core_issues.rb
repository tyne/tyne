class AddAssignedToIdToTyneCoreIssues < ActiveRecord::Migration
  def change
    add_column :tyne_core_issues, :assigned_to_id, :integer
  end
end
