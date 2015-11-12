require 'foxycart/configuration'

require 'rc4'
require 'nori'

module Foxycart
  class Datafeed

    def self.from_params(params)
      decoded = URI.unescape params

      trimmed = decoded.gsub(/FoxyData=/, '')
      encrypted = URI.unescape trimmed

      rc4 = RC4.new Foxycart.configuration.api_key
      decrypted = rc4.decrypt encrypted

      parser = Nori.new
      payload = parser.parse decrypted

      payload['foxydata']
    end

  end
end
