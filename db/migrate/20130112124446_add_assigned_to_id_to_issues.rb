class AddAssignedToIdToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :assigned_to_id, :integer
  end
end
