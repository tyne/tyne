class CreateTyneCoreSprints < ActiveRecord::Migration
  def change
    create_table :tyne_core_sprints do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.integer :project_id

      t.timestamps
    end
  end
end
