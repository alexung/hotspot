module RepositoryHelper

	def list_branches(repo)
		` cd /tmp/#{repo} && git branch -r`.split("\n").map!{|x| x.gsub(/origin\//, "")}
	end

  def repository_exists?(repo_uid)
  	Repository.find_by(repo_uid: repo_uid)
  end
	
end