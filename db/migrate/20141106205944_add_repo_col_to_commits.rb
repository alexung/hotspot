class AddRepoColToCommits < ActiveRecord::Migration
  def change
  	add_column :commits, :repository_id, :integer
  end
end
