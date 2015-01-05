class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.string :name
      t.timestamps
    end

    create_table :events do |t|
      t.string :name
      t.datetime :when
      t.string :logo_url

      t.belongs_to :stage, index: true

      t.timestamps
    end
  end
end
