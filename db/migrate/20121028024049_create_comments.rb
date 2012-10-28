class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.string :author
      t.integer :votes
      t.integer :priority

      t.timestamps
    end
  end
end
