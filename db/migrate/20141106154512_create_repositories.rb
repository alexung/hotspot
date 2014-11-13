class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.belongs_to  :user
      t.string      :name
      t.string      :url
      t.string      :repo_owner
      t.integer     :repo_uid
      t.integer     :first_commit
      t.integer     :last_commit

      t.timestamps
    end
  end
end
