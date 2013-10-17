class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string, :post_content
      t.date :post_date

      t.timestamps
    end
  end
end
