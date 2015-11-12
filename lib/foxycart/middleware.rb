require 'foxycart/configuration'
require 'foxycart/listeners'
require 'foxycart/datafeed'

module Foxycart
  class Middleware

    def initialize(app=nil)
      @app = app
    end

    def config
      Foxycart.configuration
    end

    def call(env)
      req = Rack::Request.new(env)
      return @app.call(env) unless req.path_info == config.mount_point
      return response 405 unless req.post?

      parse_and_respond req.body.read
    end

  private

    def parse_and_respond(params)
      datafeed = Datafeed.from_params params
      Foxycart.propagate datafeed
      response 200, 'foxy'
    rescue => e
      raise e if config.raise_exceptions?
      response 500
    end

    def response(status, body='', headers={})
      [
        status,
        {'Content-Type' => 'text/plain'}.merge(headers),
        [body],
      ]
    end

  end
end
