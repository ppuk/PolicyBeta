module FileUpdater
  class FolderUpdate
    def initialize(folder, new_name, old_name)
      @folder = folder
      @new_name = new_name
      @old_name = old_name
    end

    def old_file_path_component
      @old_file_path_component ||= @old_name.downcase.underscore
    end

    def new_file_path_component
      @new_file_path_component ||= @new_name.downcase.underscore
    end

    def file_needs_moving?(file)
      file =~ /#{old_file_path_component}/
    end

    def move_file(source)
      dest = source.gsub(old_file_path_component, new_file_path_component)
      puts "Moving file #{source} to #{dest}"
      FileUtils.mkdir_p(Pathname.new(dest).dirname)
      FileUtils.mv(source, dest)
    end

    def process
      loop do
        renamed = false

        files.each do |file|
          if file_needs_moving?(file)
            move_file(file)
            renamed = true
            break
          end
        end

        break unless renamed
      end

      files.each do |file|
        unless File.directory?(file)
          FileUpdate.new(file, @new_name, @old_name).process
        end
      end
    end

    def files
      Dir.glob(@folder)
    end
  end
end
