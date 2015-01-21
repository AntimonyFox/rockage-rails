class CreateWaitlistEntries < ActiveRecord::Migration
  def change
    create_table :waitlist_entries do |t|
      t.belongs_to  :tournament,  index: true
      t.belongs_to  :user,        index: true

      t.timestamps
    end
  end
end
