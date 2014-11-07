class LynxShare
	def rows
		file_paths.map do |path|
			{
	 	# git log --numstat --format=%h README.md | grep README.md
    	file_path: path, 
    	commits: commits_for(path), 
    	contributers: contributors_to(path), 
    	insertions: insertions_to(path), 
    	deletions: deletions_of(path)
    }
		end    
	end

	def file_paths
		` cd /tmp/LynxShare && git ls-files `.split("\n")
	end

	def commits_for(path)
		` cd /tmp/LynxShare && git log --format=%H #{path} | wc -l `.to_i
	end

	def contributors_to(path)
		` cd /tmp/LynxShare && git log --format=%ae #{path} | sort | uniq `.split("\n")
	end 

	def insertions_and_deletions(path)
		` cd /tmp/LynxShare && git log --numstat --format=%h #{path} | grep #{path} `.split("\n").map do |line|
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
