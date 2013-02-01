# This migration comes from tyne_core (originally 20130131201914)
class AddActiveToTyneCoreSprints < ActiveRecord::Migration
  def change
    add_column :tyne_core_sprints, :active, :boolean, :default => false
  end
end
