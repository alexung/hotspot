module CodeReviewHelper
	extend ActiveSupport::Concern
	include GithubHelper

	def list_branches(repo)
		` cd /tmp/#{repo} && git branch -r`.split("\n").map!{|x| x.gsub(/origin\//, "")}
	end
end
