class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string    :name,  null: false
      t.datetime  :when
      t.string    :slug,  null: false

      t.timestamps
    end

    create_table :entries do |t|
      t.belongs_to  :tournament,  index: true
      t.belongs_to  :user,        index: true

      t.timestamps
    end
  end
end
