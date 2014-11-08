class CodeReview
	def initialize(repo, username)
		@repo = repo
		clone_repo(repo, username)
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
		` cd /tmp/#{@repo} && git ls-files `.split("\n")
	end

	def commits_for(path)
		` cd /tmp/#{@repo} && git log --format=%H #{path} | wc -l `.to_i
	end

	def contributors_to(path)
		` cd /tmp/#{@repo} && git log --format=%ae #{path} | sort | uniq `.split("\n")
	end

	def insertions_and_deletions(path)
		` cd /tmp/#{@repo} && git log --numstat --format=%h #{path} | grep #{path} `.split("\n").map do |line|
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
end
