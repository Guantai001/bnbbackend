require_relative "boot"

require "rails/all"
require "rails/all"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bnbbackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.before_configuration do
      env_file = Rails.root.join("config", "local_env.yml")
      if File.exist?(env_file)
        YAML.load_file(env_file).each do |key, value|
          ENV[key.to_s] = value
        end
      end
    end
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    # config.before_configuration do
    #   env_file = File.join(Rails.root, "config", "local_env.yml")
    #   YAML.load(File.open(env_file)).each do |key, value|
    #     ENV[key.to_s] = value
    #   end if File.exist?(env_file)
    # end
  end
end
