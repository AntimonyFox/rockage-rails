class CreateFinalBrackets < ActiveRecord::Migration
  def change
    create_table :final_brackets do |t|
      t.belongs_to  :tournament
      t.belongs_to  :bracket

      t.timestamps
    end
  end
end
