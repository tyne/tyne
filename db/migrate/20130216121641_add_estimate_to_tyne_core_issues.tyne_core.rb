# This migration comes from tyne_core (originally 20130216121546)
class AddEstimateToTyneCoreIssues < ActiveRecord::Migration
  def change
    add_column :tyne_core_issues, :estimate, :decimal
  end
end
