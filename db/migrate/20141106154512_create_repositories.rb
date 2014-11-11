class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.belongs_to  :user
      t.string      :name
      t.string      :url
      t.string      :repo_owner
      t.integer     :repo_uid
      t.text        :branches

      t.timestamps
    end
  end
end
