class CreateRepositoryFiles < ActiveRecord::Migration
  def change
    create_table :repository_files do |t|
    	t.belongs_to :repository
        t.string   :github_url
        t.string   :name
        t.integer  :commits
        t.text     :graph_arr

    	t.timestamps
    end
  end
end
