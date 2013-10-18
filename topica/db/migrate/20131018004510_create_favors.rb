class CreateFavors < ActiveRecord::Migration
  def change
    create_table :favors do |t|
      t.references :user, index: true
      t.references :post, index: true

      t.timestamps
    end
  end
end
