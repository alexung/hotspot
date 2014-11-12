class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
    	t.integer :repo_uid
      t.text :content
      t.belongs_to :user

      t.timestamps
    end
  end
end
