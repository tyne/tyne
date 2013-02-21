class AddPositionToTyneCoreIssues < ActiveRecord::Migration
  def change
    add_column :tyne_core_issues, :position, :integer
    add_column :tyne_core_issues, :sprint_position, :integer

    TyneCore::Project.all.each do |project|
      project.issues.order("created_at").all.each_with_index do |issue, index|
        issue.position = index
        issue.save!
      end
    end
  end
end
