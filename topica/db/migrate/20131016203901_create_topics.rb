class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :topic_name
      t.integer :topic_type

      t.timestamps
    end
  end
end
