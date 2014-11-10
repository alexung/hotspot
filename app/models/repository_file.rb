class RepositoryFile < ActiveRecord::Base
	belongs_to :repository

	def self.create_repo_files(path, username, repository)
		create(
			github_url: "http://github.com/#{username}/#{repository.name}/blob/master/#{path[:file_path]}",
			repository_id: repository.id,
			name: repository.name,
			commits: path[:commits],
			contributers: path[:contributers].join(","),
			insertions: path[:insertions],
			deletions: path[:deletions]
			)
	end
end