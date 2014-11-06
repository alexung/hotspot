class SessionsController < ApplicationController

	def self.from_omniauth(auth)
		auth_email = auth[:info][:email]

		self.where(email: auth_email).first || create_with_omniauth(auth)
	end

	def create
		auth = env['omniauth.auth']
		user = User.find_or_create_by(email: auth[:info][:email].first)
		session[:user_id] = user.id
		redirect_to root_url, :notice => ""
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, :notice => ""
	end

end
