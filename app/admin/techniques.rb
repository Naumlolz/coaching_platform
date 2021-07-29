ActiveAdmin.register Technique do
  permit_params [:name, :description, :program_id]

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Technique" do
      f.input :name
      f.input :description
      f.input :program_id, as: :select, collection: Program.all.collect {|program| [program.name, program.id] }
    end
    f.actions
  end
end
