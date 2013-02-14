# This migration comes from tyne_core (originally 20130131220115)
class AddFinishedToTyneCoreSprints < ActiveRecord::Migration
  def change
    add_column :tyne_core_sprints, :finished, :date
  end
end
