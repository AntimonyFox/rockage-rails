class AddNumDescendantsToBrackets < ActiveRecord::Migration
  def change
    add_column :brackets, :num_descendants, :integer
  end
end
