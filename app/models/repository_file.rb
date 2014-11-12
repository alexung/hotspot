class RepositoryFile < ActiveRecord::Base
	belongs_to :repository
	has_many :contributions
	has_many :contributors, through: :contributions

	 validates :name, uniqueness: { scope: :repository,
    message: "File paths within a repository should be unique" }

	def self.create_repo_files(path, username, repository)
		create(
			github_url: "http://github.com/#{username}/#{repository}/blob/master/#{path[:file_path]}",
			repository_id: repository.id,
			name: path[:file_path],
			commits: path[:commits],
			insertions: path[:insertions],
			deletions: path[:deletions]
			)
	end
end