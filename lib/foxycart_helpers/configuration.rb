module FoxycartHelpers

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
    attr_accessor *[
      :logger,
      :api_key,
      :url,
      :mount_point,
      :auto_encode,
      :raise_exceptions,
    ]

    alias_method :auto_encode?, :auto_encode
    alias_method :raise_exceptions?, :raise_exceptions

    def initialize
      @mount_point      = '/foxycart_processor'
      @logger           = Logger.new STDOUT
      @api_key          = ENV.fetch 'FOXYCART_API_KEY'
      @url              = ENV['FOXYCART_URL']
      @auto_encode      = true
      @raise_exceptions = true unless ENV['RACK_ENV'] == 'production'
    end

  end
end
