class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :message
      t.integer :issue_id
      t.integer :user_id

      t.timestamps
    end

    add_index :comments, :issue_id
  end
end
