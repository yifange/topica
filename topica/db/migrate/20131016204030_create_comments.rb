class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string, :comment_content
      t.date :comment_date

      t.timestamps
    end
  end
end
