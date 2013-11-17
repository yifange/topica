class ChangeTopicTypeInTopics < ActiveRecord::Migration
  def change
    change_table :topics do |t|
      t.change :topic_type, :string
    end
  end
end
