module ApplicationHelper
  def get_commits(user, repo)
    @commits = `curl https://api.github.com/repos/#{user}/#{repo}/commits?client_id=#{ENV['GITHUB_KEY']}&client_secret=#{ENV['GITHUB_SECRET']}`
    @json = Json.parse(@commits)
  end

  def get_sha
    sha
  end

  def get_files
  end

  def files
  end

  def get_info
  end

  def add_info
  end


end
