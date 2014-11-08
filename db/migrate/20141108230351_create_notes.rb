class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :content
      t.belongs_to :user
      t.belongs_to :repository

      t.timestamps
    end
  end
end
