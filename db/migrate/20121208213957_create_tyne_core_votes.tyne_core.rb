# This migration comes from tyne_core (originally 20121208164655)
class CreateTyneCoreVotes < ActiveRecord::Migration
  def change
    create_table :tyne_core_votes do |t|
      t.references :user
      t.string :votable_type
      t.integer :votable_id
      t.integer :weight

      t.timestamps
    end

    add_index :tyne_core_votes, :user_id
    add_index :tyne_core_votes, [:votable_type, :votable_id]
  end
end
