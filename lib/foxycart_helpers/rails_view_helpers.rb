require 'foxycart_helpers/product_verification'

module FoxycartHelpers
  module RailsViewHelpers

    def foxycart_encode(code, name, value)
      FoxycartHelpers::ProductVerification.encode code, name, value
    end

    def foxycart_encoded_name(code, name, value)
      FoxycartHelpers::ProductVerification.encoded_name code, name, value
    end

    alias_method :foxycart_encoded_value, :foxycart_encoded_name

  end
end
