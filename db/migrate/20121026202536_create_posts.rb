class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :admin_id
      t.string :url
      t.string :name

      t.timestamps
    end
  end
end
