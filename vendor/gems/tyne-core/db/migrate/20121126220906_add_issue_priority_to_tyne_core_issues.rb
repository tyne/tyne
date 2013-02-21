class AddIssuePriorityToTyneCoreIssues < ActiveRecord::Migration
  def change
    add_column :tyne_core_issues, :issue_priority_id, :integer

    add_index :tyne_core_issues, :issue_priority_id
  end
end
