class Repository < ActiveRecord::Base
	has_many :repository_files, dependent: :destroy
	has_many :contributors, dependent: :destroy
	belongs_to :user
	
	def self.save_repository_to_db(username, repository, repo_uid, current_user, first_commit, last_commit)
		self.find_or_create_by(
			user_id: 		current_user,
			name: 			repository,
			url: 				"http://www.github.com/#{username}/#{repository}",
			repo_owner: username,
			repo_uid: 	repo_uid,
			first_commit: first_commit,
			last_commit: last_commit
			)
	end
end
