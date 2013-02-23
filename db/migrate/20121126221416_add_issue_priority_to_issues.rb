class AddIssuePriorityToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :issue_priority_id, :integer

    add_index :issues, :issue_priority_id
  end
end
