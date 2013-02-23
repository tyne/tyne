class CreateIssuePriorities < ActiveRecord::Migration
  def change
    create_table :issue_priorities do |t|
      t.string :name
      t.integer :number

      t.timestamps
    end

    add_index :issue_priorities, :number
  end
end
