class AddMaxnumentriesAndStatusToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :max_num_entries, :integer
    add_column :tournaments, :status, :string
  end
end
