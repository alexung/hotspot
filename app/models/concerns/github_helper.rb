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
  def unix_time_first_commit
    ` cd /tmp/#{@repo} && git log --format=%ct | tail -1 `.to_i
  end

  def unix_time_last_commit
    ` cd /tmp/#{@repo} && git log --format=%ct | head -1 `.to_i
  end

  def total_elapsed_project_time
    unix_time_last_commit - unix_time_first_commit
  end
# returns a nested array with time of commit and nested within that, an array of insertions and deletions
  def all_file_commits_data(path)
    time = ` cd /tmp/#{@repo} && git log --format=%ct #{path} `.split("\n").map{|time| time.to_i}
    ins_del = ` cd /tmp/#{@repo} && git log --numstat --format=%h #{path} | grep #{path} `.split("\n").map{|line| line.split(" ")[0..1]}.map{|insert| insert.map{|x| x.to_i}}
    time.zip(ins_del)
  end
# returns an array of tuples for the view
  def return_section_for_changes(project_time, initial_commit, unit_size, utc)
    section_size = project_time/unit_size
    time_from_first_commit = utc - initial_commit
    index_position = time_from_first_commit/section_size
  end

  def add_changes_to_graph_arr(graph_arr, index, change_values)
    unless change_values.nil? || index.nil? || graph_arr.nil? || index > 29
      graph_arr[index][0] += change_values[0]
      graph_arr[index][1] += change_values[1]
    end
  end

  def create_graph_arr(commit_times_and_values, unit_size, project_time, initial_commit)
    graph_arr = Array.new(unit_size){Array.new(2, 0)}
    commit_times_and_values.each do |commit|
      position_index = return_section_for_changes(project_time, initial_commit, unit_size, commit[0])
      add_changes_to_graph_arr(graph_arr, position_index, commit[1])
    end
    graph_arr.to_json
  end

end
