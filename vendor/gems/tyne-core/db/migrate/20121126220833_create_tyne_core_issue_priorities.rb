class CreateTyneCoreIssuePriorities < ActiveRecord::Migration
  def change
    create_table :tyne_core_issue_priorities do |t|
      t.string :name
      t.integer :number

      t.timestamps
    end

    add_index :tyne_core_issue_priorities, :number
  end
end
