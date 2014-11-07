module ApplicationHelper
  def get_commits(user, repo)
    @commits = `curl https://api.github.com/repos/#{user}/#{repo}/commits?client_id=#{ENV['GITHUB_KEY']}&client_secret=#{ENV['GITHUB_SECRET']}`
    @json = Json.parse(@commits)
  end

  def get_sha
    sha
  end

# Make api calls to github with the sha each commit (in curl).
# Return a nested array of hashes, each representing a file.
  def parse_commits(sha_arr)
    commit_arr = []
    sha_arr.each do |sha|
      commit = `curl https://api.github.com/repos/#{user}/#{repo}/commits/#{sha}?client_id=#{ENV['GITHUB_KEY']}&client_secret=#{ENV['GITHUB_SECRET']}`
      commit_arr << JSON.parse(commit)
    end
  end

  def extract_files(commit_arr)
    files_arr = commit_arr["files"].map
  end

  def files
  end

  def get_info
  end

  def add_info
  end


end

