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
      params = config.auto_encode? ? encoded_query_hash : query_hash
      string = URI.encode_www_form(params)
      return string unless config.auto_encode?
      CGI.unescape string
    end

    def query_hash
      {
        name: @name,
        price: @price,
        code: @code,
      }.merge(@opts)
    end

    def encoded_query_hash
      query_hash.map {|k,v| [k, FoxycartHelpers::ProductVerification.encoded_name(@code, k.to_s, v)]}.to_h
    end

    def initialize(name, price, code=nil, opts={})
      @name  = name
      @price = price
      @code  = code
      @opts  = opts
    end

    def config
      FoxycartHelpers.configuration
    end

  end
end
