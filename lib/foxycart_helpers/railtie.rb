require 'foxycart_helpers/middleware'
require 'foxycart_helpers/rails_view_helpers'

module FoxycartHelpers
  class Railtie < Rails::Railtie

    initializer 'foxycart_helpers.use_rack_middleware' do |app|
      app.config.middleware.use 'FoxycartHelpers::Middleware'
    end

    initializer 'foxycart_helpers.configure_view_controller' do |app|
      ActiveSupport.on_load :action_view do
        include FoxycartHelpers::RailsViewHelpers
      end
    end

  end
end
