# This migration comes from tyne_core (originally 20121126220833)
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
