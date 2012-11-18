# This migration comes from tyne_core (originally 20121118134057)
class AddStateToTyneCoreIssues < ActiveRecord::Migration
  def change
    add_column :tyne_core_issues, :state, :string, :default => 'open'
  end
end
