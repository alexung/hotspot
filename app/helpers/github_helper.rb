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

	def fetch_contributor_username(contributor_arr)
		contributor_arr.map do |contributor|
			binding.pry
			contributor["login"]
		end
	end	

	def fetch_contributor_email(username)
		path = "users/#{username}"
		fetch_gh(path)["email"]
	end

	def fetch_repo_uid(username, repository)
		path = "/repos/#{username}/#{repository}"
    fetch_gh(path)["id"]
	end

	def contributor_hash_builder(repo_user, repo_name)
		contributors_arr = fetch_gh_contributors(repo_user, repo_name)
		fetch_contributor_username(contributors_arr).map do |username|
			{ fetch_contributor_email(username) => username }
		end
	end
end