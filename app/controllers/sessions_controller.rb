class SessionsController < ApplicationController

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
