ActiveAdmin.register Technique do
  permit_params %i[name description program_id]

  form do |f|
    f.semantic_errors do
      f.object.errors.each do |attribute, message|
        concat content_tag(:li, "#{attribute.to_s.humanize} #{message}")
      end
    end

    f.inputs 'Technique' do
      f.input :name
      f.input :description
      f.input :program_id, as: :select, collection: Program.pluck(:name, :id)
    end
    f.actions
  end
end
