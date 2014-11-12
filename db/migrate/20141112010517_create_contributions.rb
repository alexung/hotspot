class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.belongs_to :repository_file
      t.belongs_to :contributor
    end
  end
end
