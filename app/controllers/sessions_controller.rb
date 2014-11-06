class SessionsController < ApplicationController

	def create
		if user = User.find(params[session_params])
			session[:user_id] = user.id
			flash[:success]
			redirect_to user_path(user)
		else
			flash[:error]
			redirect_to root_path
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end

end
