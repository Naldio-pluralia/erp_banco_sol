require_relative 'boot'

require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Next
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    # skip tests
    config.generators.specs = false
    config.generators.test_framework = nil

    # language configuration
    config.encoding = "utf-8"
    config.i18n.default_locale = :pt
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.assets.paths << "#{Rails}/vendor/assets/fonts"
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    # config.assets.paths << Rails.root.join("node_modules", "@icon", "micon")
    Rails.application.config.assets.precompile << %r{@icon/micon/[\w-]+\.(?:eot|svg|ttf|woff2?)$}
  end
end
