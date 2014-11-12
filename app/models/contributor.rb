class Contributor < ActiveRecord::Base
	belongs_to 	:repository
	has_one 		:github_user
	has_many 		:contributions
	has_many 		:repository_files, through: :contributions



	def fetch_gh_contributors(user, repo)
		path = "repos/#{user}/#{repo}/contributors"
		fetch_gh(path)
	end

end