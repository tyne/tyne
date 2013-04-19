class AddColourToLabels < ActiveRecord::Migration
  def change
    add_column :labels, :colour, :string
  end
end
