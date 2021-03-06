require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Zendogs
  CONTACT_EMAIL = Rails.env.production? ? 'zendogz3@gmail.com' : 'adamlawr@gmail.com'
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.view_specs false
      g.helper_specs false
      g.stylesheets = false
      g.javascripts = false
      g.helper = false
    end

    # use spec fixtures
    # ActiveRecord::Tasks::DatabaseTasks.fixtures_path = "#{::Rails.root}/spec/fixtures"

    # load env variables from config/application.yml
    config.before_configuration do
      env_file = Rails.root.join('config', 'application.yml')
      if File.exist?(env_file)
        YAML.safe_load(File.open(env_file)).each do |env, keys|
          next unless Rails.env == env
          keys.each do |key, value|
            # puts "#{Rails.env}: #{env}, #{key} = #{value}"
            ENV[key.to_s] = value
          end
        end
      end
    end
  end
end
