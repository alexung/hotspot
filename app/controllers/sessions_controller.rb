class SessionsController < ApplicationController

	def create
		auth = env['omniauth.auth']
		user = User.find_or_create_by(email: auth["info"]["email"])
		session[:user_id]
		redirect_to user_path(user)
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, :notice => ""
	end

end
