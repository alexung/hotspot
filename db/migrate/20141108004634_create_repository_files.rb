class CreateRepositoryFiles < ActiveRecord::Migration
  def change
    create_table :repository_files do |t|
    	t.string 			:github_url
    	t.string 			:name
    	t.belongs_to 	    :repository
    	t.integer			:insertions
    	t.integer			:deletions
    	t.string			:contributors
    	t.integer			:commits

    	t.timestamps
    end
  end
end
