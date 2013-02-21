class AddIssueNumberToTyneCoreIssues < ActiveRecord::Migration
  def change
    add_column :tyne_core_issues, :number, :integer

    add_index :tyne_core_issues, :number

    TyneCore::Project.all.each do |project|
      number = 0
      project.issues.each do |issue|
        number = number + 1
        issue.number = number
        issue.save!
      end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
