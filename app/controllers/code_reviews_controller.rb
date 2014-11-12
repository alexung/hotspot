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

		contributors = fetch_gh_contributors(@username, @repository)
		saved_repository = Repository.save_repository_to_db(@username, @repository, repo_uid, session[:user_id])
		
		contributors.map do |contributor|
			saved_repository.contributors.create(username: contributor["login"], avatar: contributor["avatar_url"])
		end.each do |contributor|
			contributor.update(email: fetch_contributor_email(contributor.username))
		end

		rows.map do |repo_file|
			new_file =	RepositoryFile.create_repo_files(repo_file, @username, saved_repository)
			repo_file[:contributors].each do |email|
				new_file.contributors << Contributor.find_by(email: email)
			end
		end
		@repository = saved_repository
		render 'repositories/show'
	end

end
