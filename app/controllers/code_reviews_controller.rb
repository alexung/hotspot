class CodeReviewsController < ApplicationController

	include CodeReviewHelper

	def new_code_review
		@individual_repo_banner = true
		@notes = Note.all
		@username = params[:username]
		@repository = params[:repo]
		@branches = list_branches(@repository)
		@username = params[:username]
		repo = fetch_gh_repo(@username, @repository)
		repo_uid = params[:uid]
		@rows = CodeReview.new(@repository, @username).rows

		saved_repository = Repository.save_repository_to_db(@username, @repository, repo_uid, session[:user_id])
		@rows.map do |repo_file|
			RepositoryFile.create_repo_files(repo_file, @username, saved_repository)
		end
		@rows.sort_by{|row_arr| -row_arr[:commits]}
		render 'repositories/show'
	end

end