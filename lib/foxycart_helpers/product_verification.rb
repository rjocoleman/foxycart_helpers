require 'foxycart_helpers/configuration'

module FoxycartHelpers
  class ProductVerification

    def self.encode(*args)
      new(*args).encode
    end

    def self.encoded_name(*args)
      new(*args).encoded_name
    end

    def encode
      digest = OpenSSL::Digest.new 'sha256'
      key = config.api_key
      data = @code + @name + @value

      OpenSSL::HMAC.hexdigest digest, key, data
    end

    def encoded_name
      @value + '||' + encode
    end

    def config
      FoxycartHelpers.configuration
    end

    def initialize(code, name, value)
      @code = code
      @name = name
      @value = value
    end

    # encoded_value is an alias for encoded_name
    singleton_class.send :alias_method, :encoded_value, :encoded_name

  end
end
