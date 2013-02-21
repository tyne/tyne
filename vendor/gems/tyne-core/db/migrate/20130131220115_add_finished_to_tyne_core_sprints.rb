class AddFinishedToTyneCoreSprints < ActiveRecord::Migration
  def change
    add_column :tyne_core_sprints, :finished, :date
  end
end
