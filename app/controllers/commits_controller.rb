class CommitsController < ApplicationController

	def index
		repo_name = 'geo'
		owner = 'kkane106'
		sha = '0986d5282c890b5e6532769935daf3db2b5334cb'
		repo_commits = `curl 'https://api.github.com/repos/#{owner}/#{repo_name}/contents/#{}`

		@commits = JSON.parse(repo_commits)
	end

	def show

	end
end