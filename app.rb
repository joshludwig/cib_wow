# encoding: utf-8
require 'sinatra'
require 'json'
require 'rest-client'

class MyApp < Sinatra::Application
  configure :production do
    set :views, ['views/layouts', 'views/pages']
    # database setup goes here
  end

  configure :development do
    set :views, ['views/layouts', 'views/pages']
    # database setup goes here
  end
end

require_relative 'helpers/init'
require_relative 'models/init'
require_relative 'controllers/init'
require_relative 'lib/init'
