class AddIssueTypeIdToTyneCoreIssues < ActiveRecord::Migration
  def change
    add_column :tyne_core_issues, :issue_type_id, :integer

    add_index :tyne_core_issues, :issue_type_id
  end
end
