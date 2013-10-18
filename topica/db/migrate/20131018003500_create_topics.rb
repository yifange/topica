class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.references :user, index: true
      t.references :feed, index: true
      t.string :name
      t.integer :topic_type

      t.timestamps
    end
  end
end
