class AddActiveToTyneCoreSprints < ActiveRecord::Migration
  def change
    add_column :tyne_core_sprints, :active, :boolean, :default => false
  end
end
