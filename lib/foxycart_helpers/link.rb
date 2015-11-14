require 'uri'

require 'foxycart_helpers/configuration'

module FoxycartHelpers
  class Link

    def self.href(*args)
      new(*args).href
    end

    def href
      url = URI::parse config.url
      url.path = '/cart'
      url.query = query_string

      url.to_s
    end

    def query_string
      URI.encode_www_form({
        name: @name,
        price: @price,
      }.merge(@opts))
    end

    def initialize(name, price, opts={})
      @name = name
      @price = price
      @opts = opts
    end

    def config
      FoxycartHelpers.configuration
    end

  end
end
