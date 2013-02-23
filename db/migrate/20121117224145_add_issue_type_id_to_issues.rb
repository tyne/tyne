class AddIssueTypeIdToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :issue_type_id, :integer

    add_index :issues, :issue_type_id
  end
end
