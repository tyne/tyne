class AddFinishedToSprints < ActiveRecord::Migration
  def change
    add_column :sprints, :finished, :date
  end
end
