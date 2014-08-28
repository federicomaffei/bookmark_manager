require 'bcrypt'
require 'rest-client'

class User

	include DataMapper::Resource

	property :id, Serial
	property :email, String, :unique => true, :message => "This email is already taken"
	property :password_digest, Text
	property :password_token, Text
	property :password_token_time, Text

	attr_reader :password, :password_token, :password_token_time	
	attr_accessor :password_confirmation
	
	validates_confirmation_of :password, :message => "Sorry, your passwords don't match"

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(email, password) # that's the user who is trying to sign in
		user = first(:email => email)
  		if user && BCrypt::Password.new(user.password_digest) == password # return this user
  			user
  		else
  			nil
  		end
  	end

  	def send_simple_message
  		key = ENV["MAILGUN_API_KEY"]
  		RestClient.post "https://api:#{key}"\
  		"@api.mailgun.net/v2/app28979029.mailgun.org/messages",
  		:from => "Mailgun Sandbox <postmaster@app28979029.mailgun.org>",
  		:to => "Bookmark Manager User <#{email}>",
  		:subject => "Password recovery link",
  		:text => "To reset password, visit http://localhost:9393/users/reset_password/#{password_token}"
  	end
  end