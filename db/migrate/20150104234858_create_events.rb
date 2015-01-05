class CreateEvents < ActiveRecord::Migration
  def change
    create_table(:events) do |t|

      t.string    :name,    null: false, default: ""
      t.datetime  :when,    null: false
      t.string    :stage,   null: false, default: ""
      t.string    :logo_url

      t.timestamps
    end
  end
end
