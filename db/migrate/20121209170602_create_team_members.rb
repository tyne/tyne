class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.integer :user_id
      t.integer :team_id
    end

    add_index :team_members, :user_id
    add_index :team_members, :team_id
  end
end
