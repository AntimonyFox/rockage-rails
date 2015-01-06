ActiveAdmin.register Event do
  permit_params :name, :when, :duration, :stage_id, :logo_url
  menu priority: 4

  index do
    selectable_column
    column :name
    column :stage
    column :when
    actions
  end

  show do |e|
    attributes_table do
      row :name
      row :when
      row "Duration (minutes)" do e[:duration] end
      row :stage
    end
  end

  after_update do
    Update.touch(:schedule)
  end

  after_create do
    Update.touch(:schedule)
  end

  after_destroy do
    Update.touch(:schedule)
  end

  filter :name
  filter :stage
  filter :when

  form do |f|
    f.inputs "Event Details" do
      f.input :name
      f.input :when, :as => :datetime_picker
      f.input :duration, label: "Duration (in minutes)"
      f.input :stage
      f.input :logo_url
    end
    f.actions
  end

end
