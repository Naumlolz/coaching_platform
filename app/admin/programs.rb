ActiveAdmin.register Program do
  permit_params :name, :description

  form do |f|
    f.semantic_errors do
      f.object.errors.each do |attribute, message|
        concat content_tag(:li, "#{attribute.to_s.humanize} #{message}")
      end
    end

    f.inputs 'Program' do
      f.input :name
      f.input :description
    end
    f.actions
  end
end
