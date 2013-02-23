class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user
      t.string :votable_type
      t.integer :votable_id
      t.integer :weight

      t.timestamps
    end

    add_index :votes, :user_id
    add_index :votes, [:votable_type, :votable_id]
  end
end
