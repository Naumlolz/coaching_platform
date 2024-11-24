ActiveAdmin.register Step do
  permit_params :title, :body, :position, :technique_id

  form do |f|
    f.semantic_errors do
      f.object.errors.each do |attribute, message|
        concat content_tag(:li, "#{attribute.to_s.humanize} #{message}")
      end
    end

    f.inputs 'Step' do
      f.input :title
      f.input :body
      f.input :position
      f.input :technique_id, as: :select, collection: Technique.pluck(:name, :id)
    end
    f.actions
  end
end
