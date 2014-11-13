class RepositoryFile < ActiveRecord::Base
	include GithubHelper
	belongs_to :repository
	has_many :contributions
	has_many :contributors, through: :contributions

	 validates :name, uniqueness: { scope: :repository,
    message: "File paths within a repository should be unique" }

	def self.create_repo_files(path, username, repository, graph_arr)
		create(
			github_url: "http://github.com/#{username}/#{repository}/blob/master/#{path[:file_path]}",
			repository_id: repository.id,
			name: path[:file_path],
			commits: path[:commits],
			graph_arr: graph_arr
			)
	end

end