class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :github_username
      t.string :github_uid
      t.string :email
      t.string :avatar_url

      t.timestamps
    end
  end
end
