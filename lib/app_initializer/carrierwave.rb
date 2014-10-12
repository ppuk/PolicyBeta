module AppInitializer

  class Carrierwave < Base
    private

    def init
      local_setup? ? setup_carrierwave_local : setup_carrierwave_fog
    end

    def local_setup?
      %w(development test).include? Rails.env
    end

    def setup_carrierwave_local
      CarrierWave.configure do |config|
        config.storage = :file
      end
    end

    def setup_carrierwave_fog
      CarrierWave.configure do |config|
        config.storage = :fog
        config.fog_credentials = {
          :provider               => 'AWS',
          :aws_access_key_id      => ENV['aws_access_key_id'],
          :aws_secret_access_key  => ENV['aws_secret_access_key'],
          :region                 => 'eu-west-1',
          :host                   => 's3.example.com',
          :endpoint               => ENV['fog_host']
        }
        config.fog_directory  = ENV['fog_content_directory']
        config.fog_public     = false
        config.fog_attributes = {
          'Cache-Control'=>'max-age=315576000'
        }
      end
    end

    def enabled?
      true
    end
  end

end

