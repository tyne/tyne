class AddIssueNumberToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :number, :integer

    add_index :issues, :number
  end
end
