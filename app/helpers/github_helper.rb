module GithubHelper
  require 'json'

  BASE_URI = "https://api.github.com"
  CREDENTIALS = "?client_id=#{ENV['GITHUB_KEY']}&client_secret=#{ENV['GITHUB_SECRET']}"

 	def fetch_gh(path)
 		JSON.parse (`curl #{BASE_URI}/#{path}#{CREDENTIALS}`)
 	end

  def fetch_gh_repos(user)
    path = "users/#{user}/repos"
    fetch_gh(path)
  end

  def fetch_gh_contributors(user, repo)
  	path = "repos/#{user}/#{repo}/contributors"
  	fetch_gh(path)
  end

  def fetch_contributor_avatar
  	self.map do |contributor|
  		contributor["avatar_url"]
  	end
  end

end