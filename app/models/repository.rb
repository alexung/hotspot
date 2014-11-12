class Repository < ActiveRecord::Base
	has_many :repository_files, dependent: :destroy
	has_many :notes, dependent: :destroy
	has_many :contributors
	belongs_to :user
	
	validates :name, uniqueness: true
	validates :url, uniqueness: true

	def self.save_repository_to_db(username, repository, repo_uid, current_user)
		self.find_or_create_by(
			user_id: 		current_user,
			name: 			repository,
			url: 				"http://www.github.com/#{username}/#{repository}",
			repo_owner: username,
			repo_uid: 	repo_uid
			)
	end
end
