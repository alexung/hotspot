class CreateFiles < ActiveRecord::Migration
  def change
    create_table :files do |t|
      t.string :url
      t.belongs_to :repository

      t.timestamps
    end
  end
end
