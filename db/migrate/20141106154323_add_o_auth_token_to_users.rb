class AddOAuthTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :oauthtoken, :string
    add_column :users, :oauthrefresh, :string
  end
end
