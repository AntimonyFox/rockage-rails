class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.string :name
      t.timestamps
    end
  end
end
