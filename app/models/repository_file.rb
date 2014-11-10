class RepositoryFile < ActiveRecord::Base
	belongs_to :repository

	def self.create_repo_files(path, username, repository)
		create do |file|
			file.github_url = "http://github.com/#{username}/#{repository.name}/blob/master/#{path[:file_path]}",
			file.repository_id = repository.id,
			file.name = repository.name,
			file.commits = path[:commits],
			file.contributers = path[:contributers].join(","),
			file.insertions = path[:insertions],
			file.deletions = path[:deletions]
		end
	end
end