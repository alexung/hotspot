class AddRepoUserIdCol < ActiveRecord::Migration
  def change
  	add_column :repositories, :user, :belongs_to
  end
end
