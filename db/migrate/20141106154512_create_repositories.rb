class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :url
      t.string :repo_owner
      t.integer :repo_uid
      t.belongs_to :user

      t.timestamps
    end
  end
end
