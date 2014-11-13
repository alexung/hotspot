class CodeReviewsController < ApplicationController

	include CodeReviewHelper

	def new_code_review
		@notes_banner = true
		@notes = Note.all
		@username = params[:username]
		@repository = params[:repo]
		@username = params[:username]
		repo_uid = params[:uid]

		review = CodeReview.new(@repository, @username)
		rows = review.rows
		saved_repository = Repository.save_repository_to_db(@username, @repository, repo_uid, session[:user_id])
		contributors = saved_repository.contributors.create(create_contributors_hash(saved_repository.name))

		gh_contributors = fetch_gh_contributors(@username, @repository)

		contributors.map do |contributor|
			if gh_contributors.select {|gh_contributor| fetch_contributor_email(gh_contributor["login"]) }.include?(contributor.email)
				gh_info = gh_contributors.select {|gh_contributor| fetch_contributor_email(gh_contributor["login"]) == contributor.email }
					contributor.create_github_user(
						username: gh_info.first["login"], 
						gh_avatar_url: gh_info.first["avatar_url"], 
						gh_repo_url: gh_info.first["url"]
					)
			end
		end	

		rows.map do |repo_file|
			graph_arr = create_graph_arr(repo_file[:graph_arr], 20, repo_file[:project_time], repo_file[:initial_commit])
			new_file =	RepositoryFile.create_repo_files(repo_file, @username, saved_repository, graph_arr)
			repo_file[:contributors].each do |email|
				new_file.contributors << Contributor.find_by(email: email)
			end
		end
		@repository = saved_repository
		render 'repositories/show'
	end

end
