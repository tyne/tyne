class CreateIssueTypes < ActiveRecord::Migration
  def change
    create_table :issue_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
