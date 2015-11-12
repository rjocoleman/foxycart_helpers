require 'logger'

require 'foxycart/version'
require 'foxycart/configuration'
require 'foxycart/listeners'
require 'foxycart/middleware'
require 'foxycart/railtie' if defined?(Rails::Railtie)
