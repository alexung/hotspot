class CreateCommit < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string  :sha
      t.string  :path
      t.string  :author
      t.string  :since
      t.string  :until
      t.string  :message
      t.integer :additions
      t.integer :deletions
      t.integer :total
    end
  end
end
