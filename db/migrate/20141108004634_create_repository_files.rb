class CreateRepositoryFiles < ActiveRecord::Migration
  def change
    create_table :project_files do |t|
    	t.string :github_url

    	t.timestamps
    end
  end
end
