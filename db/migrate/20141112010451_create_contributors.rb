class CreateContributors < ActiveRecord::Migration
  def change
    create_table :contributors do |t|
      t.belongs_to :repository
      t.string :email
      t.string :username
      t.string :gravatar_url
    end
  end
end
