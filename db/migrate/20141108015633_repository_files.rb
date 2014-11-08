class RepositoryFiles < ActiveRecord::Migration
  def change
    create_table :repository_files do |t|
      t.string :name
      t.string :url
      t.belongs_to :repository

      t.timestamps
    end
  end
end
