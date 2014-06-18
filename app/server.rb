require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require './lib/link'
require './lib/user'
require './lib/tag'
require_relative 'helpers/user_helper'
require_relative 'data_mapper_setup'
 # this needs to be done after datamapper is initialised

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash

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
  @user = User.new
  erb :"users/new"
end

get '/sessions/new' do
	erb :"sessions/new"
end

get "/users/reset_password/:token" do
	
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
	@user = User.new(:email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation])
	if @user.save
		session[:user_id] = @user.id
		redirect to('/')
	else 
		flash.now[:errors] = @user.errors.full_messages
		erb :"users/new"
	end
end

post '/sessions' do
  email, password = params[:email], params[:password]
  user = User.authenticate(email, password)
  if user
    session[:user_id] = user.id
    redirect to('/')
  else
    flash[:errors] = ["The email or password is incorrect"]
    erb :"sessions/new"
  end
end

post '/recovery' do
	email = params[:email]
	user = User.first(:email => email) # avoid having to memorise ascii codes
	user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
	user.password_token_timestamp = Time.now
	user.save
end

delete '/sessions' do
	session[:user_id] = nil
	flash[:notice] = ['Good bye!']
	redirect to('/')
end	

