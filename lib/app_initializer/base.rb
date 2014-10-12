module AppInitializer

  class Base
    def initialize(config_file = nil)
      @config_file = config_file
      init if enabled?
    end

    private

    def enabled?
      !!config[:enabled]
    end

    def init
      raise 'init needs to be overridden'
    end

    def config_path
      @config_path ||= File.join(Rails.root, 'config', @config_file)
    end

    def environment
      Rails.env.to_s
    end

    def config
      @config ||= YAML.load_file(config_path).with_indifferent_access[environment]
    end
  end

end
