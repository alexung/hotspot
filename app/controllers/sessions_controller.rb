class SessionsController < ApplicationController

	def create
		auth = env['omniauth.auth']
		if user = User.where(email: auth["info"]["email"]).first
		session[:user_id] = user.id
		redirect_to user_path(User.find(session[:user_id]))
		else
			user = User.create_with_omniauth(auth)
			session[:user_id] = user.id
			redirect_to user_path(User.find(session[:user_id]))
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "You have successfully logged out"
		redirect_to root_url
	end

end
