class AddStatusColumnsToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :current_round, :integer,  default: 0
    add_column :tournaments, :current_match, :integer,  default: 0
  end
end
