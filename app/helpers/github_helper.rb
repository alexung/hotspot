module GithubHelper
  require 'json'

  def fetch_gh_repos(opts={})
    base_uri = "https://api.github.com"
    JSON.parse(
      `curl #{base_uri}/users/#{opts[:user]}/repos?client_id=#{ENV['GITHUB_KEY']}&client_secret=#{ENV['GITHUB_SECRET']}`
    )
  end

end