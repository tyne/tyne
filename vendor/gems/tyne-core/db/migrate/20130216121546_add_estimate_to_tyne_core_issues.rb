class AddEstimateToTyneCoreIssues < ActiveRecord::Migration
  def change
    add_column :tyne_core_issues, :estimate, :decimal
  end
end
