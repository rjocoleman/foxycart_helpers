require 'foxycart_helpers/product_verification'
require 'foxycart_helpers/link'
require 'foxycart_helpers/javascript'

module FoxycartHelpers
  module RailsViewHelpers

    def foxycart_encode(code, name, value)
      FoxycartHelpers::ProductVerification.encode code, name, value
    end

    def foxycart_encoded_name(code, name, value)
      FoxycartHelpers::ProductVerification.encoded_name code, name, value
    end

    def foxycart_url_for(name, price, code=nil, opts={})
      FoxycartHelpers::Link.href name, price, code, opts
    end

    def foxycart_loader_js_url
      FoxycartHelpers::Javascript.url
    end

    def foxycart_loader_js
      FoxycartHelpers::Javascript.html_element
    end

    alias_method :foxycart_encoded_value, :foxycart_encoded_name

  end
end
