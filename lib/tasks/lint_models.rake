require 'rake'
require 'rubocop/rake_task'

#run command bundle exec rake lint:models 

namespace :lint do
  desc 'Run Rubocop on all files in spec/models directory'
  RuboCop::RakeTask.new(:models) do |task|
    task.patterns = ['spec/models/**/*.rb']
  end
end
