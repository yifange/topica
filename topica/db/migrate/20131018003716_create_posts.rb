class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true
      t.text :title
      t.text :content

      t.timestamps
    end
  end
end
