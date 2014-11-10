class CreateContributors < ActiveRecord::Migration
  def change
    create_table :contributors do |t|
    	t.belongs_to :repository_file
      t.string :avatar_path
    end
  end
end
