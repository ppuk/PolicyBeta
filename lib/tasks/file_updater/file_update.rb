module FileUpdater
  class FileUpdate
    def initialize(filename, new_name, old_name)
      @filename = filename

      @new_class_name = new_name.camelize
      @new_instance_name = new_name.downcase.underscore

      @old_class_name = old_name.camelize
      @old_instance_name = old_name.downcase.underscore
    end

    def process
      changed = nil
      changed ||= file_contents.gsub!(@old_class_name, @new_class_name)
      changed ||= file_contents.gsub!(@old_instance_name, @new_instance_name)
      write_file if changed
    end

    def file_contents
      @file_contents ||= File.read(@filename)
    end

    def write_file
      puts "writing #{@filename}"
      File.open(@filename, 'w') { |file| file.puts file_contents }
    end
  end
end
