class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.references :topic, index: true
      t.references :post, index: true

      t.timestamps
    end
  end
end
