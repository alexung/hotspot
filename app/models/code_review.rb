class CodeReview
	include GithubHelper
	include ApplicationHelper
	attr_reader :repo, :username

	def initialize(repo, username)
		@repo = repo
		@username = username
		clone_repo(repo, username)
		@project_time = total_elapsed_project_time
		@initial_commit = unix_time_first_commit
		@last_commit = unix_time_last_commit
	end

	def rows
		file_paths.map do |path|
			{
				file_path: path,
				commits: commits_for(path),
				contributors: contributors_to(path),
				graph_arr: all_file_commits_data(path),
				project_time: @project_time,
				initial_commit: @initial_commit,
				last_commit: @last_commit
			}
		end
	end



end