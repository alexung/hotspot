class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :text
      t.belongs_to :user

      t.timestamps
    end
  end
end
