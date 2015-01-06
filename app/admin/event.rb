ActiveAdmin.register Event do
  permit_params :name, :when, :stage_id, :logo_url
  menu priority: 4

  index do
    selectable_column
    column :name
    column :stage
    column :when
    actions
  end

  after_update do |e|
    Update.touch(:schedule)
  end

  filter :name
  filter :stage
  filter :when

  form do |f|
    f.inputs "Event Details" do
      f.input :name
      f.input :when, :as => :datetime_picker
      f.input :stage
      f.input :logo_url
    end
    f.actions
  end

end
