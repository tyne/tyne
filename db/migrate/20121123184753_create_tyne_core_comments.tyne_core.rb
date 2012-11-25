# This migration comes from tyne_core (originally 20121123184313)
class CreateTyneCoreComments < ActiveRecord::Migration
  def change
    create_table :tyne_core_comments do |t|
      t.text :message
      t.integer :issue_id
      t.integer :user_id

      t.timestamps
    end

    add_index :tyne_core_comments, :issue_id
  end
end
