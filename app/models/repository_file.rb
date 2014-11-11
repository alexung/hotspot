class RepositoryFile < ActiveRecord::Base
	belongs_to :repository
	validates :name, uniqueness: {scope: :repository,
						message: "File paths within a repository should be unique"}

	def self.create_repo_files(path, username, repository)
		create(
			github_url: "http://github.com/#{username}/#{repository}/blob/master/#{path[:file_path]}",
			repository_id: repository.id,
			name: path[:file_path],
			commits: path[:commits],
			contributers: path[:contributers].join(","),
			insertions: path[:insertions],
			deletions: path[:deletions]
			)
	end
end
