require 'foxycart/middleware'

module Foxycart
  class Railtie < Rails::Railtie

    initializer 'foxycart.use_rack_middleware' do |app|
      app.config.middleware.use 'Foxycart::Middleware'
    end

  end
end
