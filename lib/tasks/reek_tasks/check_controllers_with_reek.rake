# run command bin/rake reek_tasks:check_controllers_with_reek:check

namespace :reek_tasks do
  namespace :check_controllers_with_reek do
    desc "Проверяет все файлы моделей с помощью reek"
    task :check => :environment do
      Dir.glob(Rails.root.join("app/controllers/**/*.rb")) do |file_path|
        system("bundle exec reek #{file_path}")
      end
    end
  end
end
