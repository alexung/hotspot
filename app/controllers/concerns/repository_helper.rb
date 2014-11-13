module RepositoryHelper

  extend ActiveSupport::Concern
  include CodeReviewHelper

  def repository_exists?(repo_uid)
  	Repository.find_by(repo_uid: repo_uid)
  end


	def contributors_to_repository(repository_name)
		` cd /tmp/#{repository_name} && git log --format=%ae | sort | uniq `.split("\n")
	end

	def create_contributors_hash(repository_name)
		contributors_to_repository(repository_name).map do |email|
			{ email: email, gravatar_url: avatar_url(email)}
		end
	end

  def avatar_url(gh_email)
    default_url = "http://www.gravatar.com/avatar/00000000000000000000000000000000?s=30"
    gravatar_id = Digest::MD5.hexdigest(gh_email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=30&d=#{CGI.escape(default_url)}"
  end

  def fetch_contributor_username(contributor_arr)
    contributor_arr.map do |contributor|
      contributor["login"]
    end
  end

  def fetch_gh_contributors(user, repo)
    path = "repos/#{user}/#{repo}/contributors"
    fetch_gh(path)
  end

  def fetch_contributor_email(username)
    path = "users/#{username}"
    fetch_gh(path)["email"]
  end

  def unix_time_first_commit
    ` cd /tmp/#{@repo} && git log --format=%ct | tail -1 `.to_i
  end

  def unix_time_last_commit
    ` cd /tmp/#{@repo} && git log --format=%ct | head -1 `.to_i
  end
end

