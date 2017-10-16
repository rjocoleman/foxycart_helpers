require 'foxycart_helpers/configuration'
require 'openssl'

module FoxycartHelpers
  class ProductVerification

    def self.encode(code, name, value)
      new(code, name, value).encode
    end

    def self.encoded_name(code, name, value)
      new(code, name, value).encoded_name
    end

    def self.encoded_value(code, name, value)
      new(code, name, value).encoded_value
    end

    def encode
      digest = OpenSSL::Digest.new 'sha256'
      key = config.api_key
      data = @code + normalized_name + @value

      OpenSSL::HMAC.hexdigest digest, key, data
    end

    def encoded_name
      if @value == '--OPEN--'
        @name + '||' + encode + '||open'
      else
        @name + '||' + encode
      end
    end

    def encoded_value
      if @value == '--OPEN--'
        @name + '||' + encode + '||open'
      else
        @value + '||' + encode
      end
    end

    def config
      FoxycartHelpers.configuration
    end

    def initialize(code, name, value)
      @code = code
      @name = name
      @value = value
    end

    private

    def normalized_name
      if @name.match /^\d*:.*/
        @name.split(':').last
      else
        @name
      end
    end
  end
end
