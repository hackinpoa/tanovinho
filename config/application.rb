require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tanovinho
  class Application < Rails::Application
    config.time_zone = 'Brasilia'

    config.i18n.default_locale = :'pt-BR'
    config.i18n.available_locales = :'pt-BR'

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end
