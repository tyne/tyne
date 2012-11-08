# This migration comes from tyne_core (originally 20121108210717)
class AddUserIdToTyneCoreProjects < ActiveRecord::Migration
  def change
    add_column :tyne_core_projects, :user_id, :integer

    add_index :tyne_core_projects, :user_id
  end
end
