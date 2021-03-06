require 'foxycart_helpers/configuration'

require 'rc4'
require 'nori'

module FoxycartHelpers
  class Datafeed

    def self.from_params(params)
      encrypted = CGI::unescape params

      rc4 = RC4.new FoxycartHelpers.configuration.api_key
      decrypted = rc4.decrypt encrypted

      parser = Nori.new
      payload = parser.parse decrypted

      payload['foxydata']
    end

  end
end
