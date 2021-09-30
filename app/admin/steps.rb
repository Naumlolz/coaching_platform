ActiveAdmin.register Step do
  permit_params :title, :body, :position, :technique_id

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Step" do
      f.input :title
      f.input :body
      f.input :position
      f.input :technique_id, as: :select, collection: Technique.all.pluck(:name, :id)
    end
    f.actions
  end
end
