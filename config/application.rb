require 'bundler'

Bundler.require

Dir.glob('./app/*.rb').each { |f| require f }
