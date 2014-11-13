module GithubHelper
  extend ActiveSupport::Concern
# Methods related to making api calls
  included do
    require 'json'
    BASE_URI = "https://api.github.com"
    CREDENTIALS = "\\?client_id\\=#{ENV['GITHUB_KEY']}\\&client_secret\\=#{ENV['GITHUB_SECRET']}"
  end

  def fetch_gh(path)
    JSON.parse(`curl #{BASE_URI}/#{path}#{CREDENTIALS}`)
  end

  def fetch_gh_repo(user, repo)
    path = "repos/#{user}/#{repo}"
    fetch_gh(path)
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
      contributor["login"]
    end
  end

  def fetch_contributor_email(username)
    path = "users/#{username}"
    fetch_gh(path)["email"]
  end

  def contributor_hash_builder(repo_user, repo_name)
    contributors_arr = fetch_gh_contributors(repo_user, repo_name)
    fetch_contributor_username(contributors_arr).map do |username|
      { fetch_contributor_email(username) => username }
    end
  end
# Methods pertaining to making a new code review
  def clone_repo(repo_name, username)
    ` git clone http://github.com/#{username}/#{repo_name}.git /tmp/#{repo_name} `
  end

  def file_paths
    ` cd /tmp/#{@repo} && git ls-files `.split("\n")
  end

  def commits_for(path)
    ` cd /tmp/#{@repo} && git log --format=%H #{path} | wc -l `
  end

  def contributors_to(path)
    contributor_arr = ` cd /tmp/#{@repo} && git log --format=%ae #{path} | sort | uniq `.split("\n")
  end

  def insertions_and_deletions(path)
    ` cd /tmp/#{@repo} && git log --numstat --format=%h #{path} | grep #{path} `.split("\n").map{|line| line.split(" ")}
  end

  def insertions_to(path)
    insertions_and_deletions(path).map do |insertion_and_deletion|
      insertion_and_deletion[0].to_i
    end.reduce(:+)
  end

  def deletions_of(path)
    insertions_and_deletions(path).map do |insertion_and_deletion|
      insertion_and_deletion[1].to_i
    end.reduce(:+)
  end
# Methods to build graph
  def unix_time_first_commit(path)
    ` cd /tmp/#{repo} && git log --format=%ct | tail -1 `
  end

  def unix_time_last_commit(path)
    ` cd /tmp/#{repo} && git log --format=%ct | head -1 `
  end

  def total_elapsed_project_time(path)
    unix_time_last_commit(path) - unix_time_first_commit(path)
  end

  def all_file_commits_data(path)
    time = ` cd /tmp/#{@repo} && git log --format=%ct #{path} `.split("\n")
    ins_del = ` cd /tmp/#{@repo} && git log --numstat --format=%h #{path} | grep #{path} `.split("\n").map{|line| line.split(" ")[0..1]}
    time.zip(ins_del)
  end
end
