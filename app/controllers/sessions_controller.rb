class SessionsController < ApplicationController

	def create
		auth = env['omniauth.auth']
		if user = User.find_by_github_uid(auth["uid"])
			session[:user_id]
			redirect_to user_path(user)
		else
			user = User.create_with_omniauth(auth)
			session[:user_id] = user.id
			redirect_to root_url, :notice => ""
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, :notice => ""
	end

end
