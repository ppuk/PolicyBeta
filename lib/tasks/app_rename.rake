require "active_support/inflector"
load 'lib/tasks/file_updater/file_update.rb'
load 'lib/tasks/file_updater/folder_update.rb'

namespace :app do
  desc 'Sets the app name throughout. Usage: be rake app:rename TO=AppName'
  task :rename do
    new_name = ENV['TO']
    old_name = ENV['FROM'] || 'PolicyBeta'

    folders = [
      'app/**/*',
      'config/**/*',
      'db/**/*',
      'lib/**/*',
      'spec/**/*',
      '*'
    ]

    folders.each do |folder|
      FileUpdater::FolderUpdate.new(folder, new_name, old_name).process
    end
  end
end
