require 'sinatra'
require 'sinatra/partial'
require 'data_mapper'
require 'rack-flash'
require './lib/link'
require './lib/user'
require './lib/tag'
require_relative 'helpers/user_helper'
require_relative 'data_mapper_setup'

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash
set :partial_template_engine, :erb
set :public_folder, 'assets'
set :root, File.dirname(__FILE__)
enable :static

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

get '/links/new' do
	erb :"links/new"
end

get '/users/reset_password' do
	erb :"users/reset_password"
end

get "/users/reset_password/:token" do
	@token = params[:token]
	user = User.first(:password_token => @token)
	user ? redirect_to_new_password : error_message_display
end

def redirect_to_new_password
	erb :'users/new_password'	
end

def error_message_display
	flash[:notice] = "This link is not valid anymore"
end

post '/links' do
	url = params["url"]
	title = params["title"]
	tags = params["tags"].split(" ").map do |tag|
		Tag.first_or_create(:text => tag)
	end
	description = params["description"]
	current_user ? created_by = current_user.email : created_by = "unsigned user"
	Link.create(:url => url.gsub('http://', ''), :title => title, :tags => tags, :created_by => created_by, :description => description)
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
	user = User.first(:email => email)
	user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
	user.password_token_time = Time.now
	user.save
	user.send_simple_message
	flash[:notice] = "An email with the instructions to reset the password has been sent."
end

post '/new_password' do
	user = User.first(:password_token => params[:token])
	user.update(:password => params[:password], :password_confirmation => params[:password_confirmation], :password_token => nil)
	user.save
	flash[:notice] = "The password has been changed"
end

post '/tags' do
	tag = Tag.first(:text => params[:tag])
	@links = tag ? tag.links : []
	erb :index
end	

delete '/sessions' do
	flash[:notice] = "Good bye!"
	session[:user_id] = nil
	redirect to('/')
end	

