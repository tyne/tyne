class AddEstimateToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :estimate, :decimal
  end
end
