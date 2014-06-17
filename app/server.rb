require 'sinatra'
require 'data_mapper'
require './lib/link'
require './lib/user'
require './lib/tag'
require_relative 'helpers/user_helper'
require_relative 'data_mapper_setup'
 # this needs to be done after datamapper is initialised

enable :sessions
set :session_secret, 'super secret'

get '/' do
	@links = Link.all
	erb :index
end

get '/tags/:text' do
	tag = Tag.first(:text => params[:text])
	@links = tag ? tag.links : []
	erb :index
end

get '/users/new' do
  # note the view is in views/users/new.erb
  # we need the quotes because otherwise
  # ruby would divide the symbol :users by the
  # variable new (which makes no sense)
  erb :"users/new"
end

post '/links' do
	url = params["url"]
	title = params["title"]
	tags = params["tags"].split(" ").map do |tag|
		Tag.first_or_create(:text => tag)
	end
	Link.create(:url => url, :title => title, :tags => tags)
	redirect to('/')
end

post '/users' do
	User.create(:email => params[:email], :password => params[:password])
	session[:user_id] = user.id
	redirect to('/')
end








