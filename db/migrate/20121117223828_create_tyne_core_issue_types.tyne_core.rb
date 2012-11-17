# This migration comes from tyne_core (originally 20121117222529)
class CreateTyneCoreIssueTypes < ActiveRecord::Migration
  def change
    create_table :tyne_core_issue_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
