require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Tales
  class Application < Rails::Application
    config.time_zone = 'Warsaw'
    config.i18n.enforce_available_locales = true
    config.i18n.available_locales = [:pl]
    config.i18n.default_locale = :pl
    config.sass.preferred_syntax = :sass
  end
end
