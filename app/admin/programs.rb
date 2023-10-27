ActiveAdmin.register Program do
  permit_params :name, :description

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs 'Program' do
      f.input :name
      f.input :description
    end
    f.actions
  end
end
