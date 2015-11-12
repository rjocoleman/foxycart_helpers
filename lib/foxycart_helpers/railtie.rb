require 'foxycart_helpers/middleware'

module FoxycartHelpers
  class Railtie < Rails::Railtie

    initializer 'foxycart_helpers.use_rack_middleware' do |app|
      app.config.middleware.use 'FoxycartHelpers::Middleware'
    end

  end
end
