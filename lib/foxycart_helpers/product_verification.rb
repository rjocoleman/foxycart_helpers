require 'foxycart_helpers/configuration'

module FoxycartHelpers
  class ProductVerification

    def self.encode(code, name, value)
      digest = OpenSSL::Digest.new 'sha256'
      key = FoxycartHelpers.configuration.api_key
      data = code + name + value

      OpenSSL::HMAC.hexdigest digest, key, data
    end

  end
end
