class CreateTyneCoreTeamMembers < ActiveRecord::Migration
  def up
    create_table :tyne_core_team_members do |t|
      t.integer :user_id
      t.integer :team_id
    end

    add_index :tyne_core_team_members, :user_id
    add_index :tyne_core_team_members, :team_id

    TyneCore::Project.all.each do |project|
      owners = project.teams.build(:name => "Owners") do |team|
        team.admin_privileges = true
      end
      owners.save!

      owner = owners.members.build do |member|
        member.user = project.user
      end
      owner.save!

      contributors = project.teams.build(:name => "Contributors")
      contributors.save!
    end
  end

  def down
    drop_table :tyne_core_team_members
  end
end
