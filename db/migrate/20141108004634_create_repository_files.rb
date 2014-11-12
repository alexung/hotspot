class CreateRepositoryFiles < ActiveRecord::Migration
  def change
    create_table :repository_files do |t|
    	t.belongs_to :repository
        t.string   :github_url
        t.string   :name
    	t.integer  :insertions
    	t.integer  :deletions
    	t.integer  :commits

    	t.timestamps
    end
  end
end
