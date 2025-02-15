# for example run
# bundle exec rake 'generate:service[notifications/technique_rate_notification_service]'

namespace :generate do
  desc 'Generate a new service object'
  task :service, [:path] => :environment do |task, args|
    path = args[:path]
    
    unless path.present?
      puts 'Please provide a valid file path. Example: rake generate:service[path=notifications/technique_rate_notification_service]'
      next
    end

    class_name = path.camelize
    full_path = Rails.root.join("app/services/#{path}.rb")

    if File.exist?(full_path)
      puts "File already exists at #{full_path}"
      next
    end

    Dir.mkdir(File.dirname(full_path)) unless File.directory?(File.dirname(full_path))

    File.open(full_path, 'w') do |file|
      file.puts <<~RUBY
        class #{class_name}
          def initialize(params)
          end

          def perform
          end

          private
        end
      RUBY
    end

    puts "Successfully generated file at #{full_path}"
  end
end
