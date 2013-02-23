class AddPositionToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :position, :integer
    add_column :issues, :sprint_position, :integer

    Project.all.each do |project|
      project.issues.order("created_at").all.each_with_index do |issue, index|
        issue.position = index
        issue.save!
      end
    end
  end
end
