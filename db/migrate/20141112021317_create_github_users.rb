class CreateGithubUsers < ActiveRecord::Migration
  def change
    create_table :github_users do |t|
      t.string :username
      t.string :gh_avatar
    end
  end
end
