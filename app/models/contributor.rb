class Contributor < ActiveRecord::Base
	belongs_to 	:repository
	has_one 		:gh_user
	has_many 		:contributions
	has_many 		:repository_files, through: :contributions
end