require './app/server'
require 'sprockets'

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'app/assets/css'
  environment.append_path 'app/users/css'
  environment.append_path 'app/links/css'
  run environment
end

map '/' do
  run Sinatra::Application
end