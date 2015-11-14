require 'foxycart_helpers/configuration'

module FoxycartHelpers
  class Javascript

    def self.url(*args)
      new(*args).url
    end

    def self.html_element(*args)
      new(*args).html_element
    end

    def url
      "https://cdn.foxycart.com/#{subdomain}/loader.js"
    end

    def html_element
      "<script src=\"#{url}\" async defer></script>"
    end

    def subdomain
      url = URI.parse config.url
      url.host.split('.').first
    end

    def config
      FoxycartHelpers.configuration
    end

  end
end
