require File.expand_path('../boot', __FILE__)
require 'rails/all'

# Display information about the search request (duration, search definition)
# during development, and to include the information in the Rails log file.
require 'elasticsearch/rails/instrumentation'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module PolicyBeta
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    config.autoload_paths += %W(#{config.root}/lib)

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.available_locales = [:en, :json]
    config.i18n.default_locale = :en
    config.i18n.load_path += Dir[
      Rails.root.join(
        'config',
        'locales',
        '**',
        '*.{rb,yml}'
      ).to_s
    ]

    config.action_mailer.default_url_options = { host: ENV['EMAIL_HOST']}

    config.exceptions_app = self.routes
  end
end
