ActiveAdmin.register Stage do
  permit_params :name
  menu priority: 3

  index do
    selectable_column
    column :name
    actions
  end

  show do
    attributes_table do
      row :name
      table_for stage.events do
        column "Events" do |e|
          link_to e.name, admin_event_path(e.id)
        end
      end
    end
  end

  filter :name

  # form do |f|
  #   f.inputs "Admin Details" do
  #     f.input :email
  #     f.input :password
  #     f.input :password_confirmation
  #   end
  #   f.actions
  # end

end
