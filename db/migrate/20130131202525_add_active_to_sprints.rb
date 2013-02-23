class AddActiveToSprints < ActiveRecord::Migration
  def change
    add_column :sprints, :active, :boolean, :default => false
  end
end
