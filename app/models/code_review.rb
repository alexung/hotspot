class CodeReview
	include GithubHelper

	def initialize(repo, username, branch = "")
		@repo = repo
		@branch = branch
		clone_repo(repo, username)
		@starting_index = index_value
	end

 	def index_value
 		if new_branch?
 			return 2
 		else
 			1
 		end
 	end

 	def new_branch?
 		@branch != ""
 	end

	def rows
		file_paths.map do |path|
			{
    	file_path: path,
    	commits: commits_for(path),
    	contributers: contributors_to(path),
    	insertions: insertions_to(path),
    	deletions: deletions_of(path)
    }
		end
	end

	def clone_repo(repo_name, username)
		` git clone http://github.com/#{username}/#{repo_name}.git /tmp/#{repo_name} `
	end

	def file_paths
		` cd /tmp/#{@repo} && git checkout #{@branch} && git ls-files `.split("\n")[@starting_index..-1]
	end

	def commits_for(path)
		` cd /tmp/#{@repo} && git checkout #{@branch} && git log --format=%H #{path} | wc -l `.split("\n")[@starting_index].to_i	
	end

	def contributors_to(path)
		` cd /tmp/#{@repo} && git checkout #{@branch} && git log --format=%ae #{path} | sort | uniq `.split("\n")[@starting_index..-1]
	end

	def insertions_and_deletions(path)
		` cd /tmp/#{@repo} && git checkout #{@branch} && git log --numstat --format=%h #{path} | grep #{path} `.split("\n")[@starting_index..-1].map do |line|
			line.split(" ")
		end
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

 	def checkout_and_review_branch
 		` cd /tmp/#{@repo} && git checkout #{@branch} `
 	end

end