class SearchesController < ApplicationController

	include SearchHelper

	def index
		@saved_repositories_banner = true
		@notes = Note.all
		@user = params[:username]
		@repositories = fetch_gh_repos(@user)

		if @repositories.class == Array
			render 'repositories/index'
		else
			flash[:error] = "No user was found with that username."
			redirect_to user_path(User.find(session[:user_id]))
		end
	end
end
