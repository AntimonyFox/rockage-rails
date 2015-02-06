ActiveAdmin.register Setting do
  permit_params :key, :value
  menu priority: 4

  index do
    selectable_column
    id_column
    column :key
    column :value
    actions
  end
end
