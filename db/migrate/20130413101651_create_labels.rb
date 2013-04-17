class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.string :name
      t.integer :project_id

      t.timestamps
    end

    create_table :issue_labels do |t|
      t.integer :issue_id
      t.integer :label_id
    end
  end
end
