class AddPrivacyToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :privacy, :boolean, :default => false
  end
end
