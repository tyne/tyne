class AddUserIdToTyneCoreProjects < ActiveRecord::Migration
  def change
    add_column :tyne_core_projects, :user_id, :integer

    add_index :tyne_core_projects, :user_id
  end
end
