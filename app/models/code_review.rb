class CodeReview
	include GithubHelper
	include ApplicationHelper
	attr_reader :repo, :username

	def initialize(repo, username)
		@repo = repo
		@username = username
		clone_repo(repo, username)
	end

	def rows
		file_paths.map do |path|
			{
				file_path: path,
				commits: commits_for(path),
				contributors: contributors_to(path),
				insertions: insertions_to(path),
				deletions: deletions_of(path)
			}
		end
	end



end