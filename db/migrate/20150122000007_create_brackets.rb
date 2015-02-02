class CreateBrackets < ActiveRecord::Migration
  def change
    create_table :brackets do |t|
      t.belongs_to  :tournament
      t.belongs_to  :bracket

      t.integer     :round_number
      t.integer     :match_number

      t.timestamps
    end

    create_table :standings do |t|
      t.belongs_to  :user
      t.belongs_to  :bracket

      t.timestamps
    end
  end
end
