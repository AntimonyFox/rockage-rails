ActiveAdmin.register Tournament, :as => "Tourns" do
  permit_params :name, :when, :slug, :max_num_entries, :status, :current_round, :current_match

end
