module RepositoryHelper

	def list_branches(repo)
		` cd /tmp/#{repo} && git branch -r`.split("\n").map!{|x| x.gsub(/origin\//, "")}
	end

  def repository_exists?(repo_uid)
  	Repository.find_by(repo_uid: repo_uid)
  end

  def save_repository_to_db(username, repository, repo_uid)
  	repository_to_database = Repository.new(user_id: session[:user_id], name: params[:repo], url: "http://www.github.com/#{username}/#{repository}", repo_owner: username, repo_uid: repo_uid)
    binding.pry
    repository_to_database.save
  end
end