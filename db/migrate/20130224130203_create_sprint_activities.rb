class CreateSprintActivities < ActiveRecord::Migration
  def change
    create_table :sprint_activities do |t|
      t.integer :sprint_id
      t.integer :issue_id
      t.string :type_of_change
      t.decimal :scope_change

      t.timestamps
    end

    add_index :sprint_activities, :sprint_id
    add_index :sprint_activities, :issue_id
  end
end
