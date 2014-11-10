class CodeReview
	include GithubHelper
	include ApplicationHelper
	attr_reader :repo, :branch, :username

	def initialize(repo, username, branch = "")
		@repo = repo
		@branch = branch
		@username = username
		clone_repo(repo, username)
		@starting_index = index_value
		@contributor_hash = contributor_hash_builder(@username, @repo).first
	end

 	def index_value
 		new_branch? ? 2 : 1
 	end

 	def new_branch?
 		@branch != ""
 	end

	def rows
		file_paths.map do |path|
			{
    	file_path: path,
    	commits: commits_for(path),
    	contributers: contributors_to(path),
    	insertions: insertions_to(path),
    	deletions: deletions_of(path)
    }
		end
	end
end
