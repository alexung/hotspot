class CodeReviewsController < ApplicationController

	include CodeReviewHelper

	def new_code_review
		@notes_banner = true
		@notes = Note.all
		@username = params[:username]
		@repository = params[:repo]
		@username = params[:username]
		repo_uid = params[:uid]
		rows = CodeReview.new(@repository, @username).rows

		saved_repository = Repository.save_repository_to_db(@username, @repository, repo_uid, session[:user_id])
		rows.map do |repo_file|
			RepositoryFile.create_repo_files(repo_file, @username, saved_repository)
		end
		@repository = saved_repository
		render 'repositories/show'
	end

end
