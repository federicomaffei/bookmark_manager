require './app/server'

run Sinatra::Application

use Rack::Static, :urls => ['/css', '/javascripts'], :root => 'public'