class CreateTyneCoreIssueTypes < ActiveRecord::Migration
  def change
    create_table :tyne_core_issue_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
